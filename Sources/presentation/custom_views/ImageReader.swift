//
//  Untitled.swift
//  Chatbot
//
//  Created by badr_hourimeche on 10/10/2024.
//

import SwiftUI
import UIKit

struct ImageReader: View {
    var url: String?
    @State var uiImage: UIImage = UIImage()
    
    var body: some View {
        if let imageUrl = URL(string: url ?? "") {
            Image(uiImage: self.uiImage)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear {
                    loadImage(from: imageUrl)
                }
        }
    }
    
    func loadImage(from url: URL) {
        // Determine the file extension
        let fileExtension = url.pathExtension.lowercased()
        
        switch fileExtension {
        case "svg":
            loadSVG(from: url)
        default :
            loadRasterImage(from: url)
        }
    }

    // Load and render SVG image
    func loadSVG(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            if let svg = SVG(data) {
                let render = UIGraphicsImageRenderer(size: svg.size)
                self.uiImage = render.image { context in
                    svg.draw(in: context.cgContext)
                }
            }
        }
    }

    // Load PNG or JPEG image
    func loadRasterImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.uiImage = image
                }
            }
        }
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

@objc
class CGSVGDocument: NSObject { }

var CGSVGDocumentRetain: (@convention(c) (CGSVGDocument?) -> Unmanaged<CGSVGDocument>?) = load("CGSVGDocumentRetain")
var CGSVGDocumentRelease: (@convention(c) (CGSVGDocument?) -> Void) = load("CGSVGDocumentRelease")
var CGSVGDocumentCreateFromData: (@convention(c) (CFData?, CFDictionary?) -> Unmanaged<CGSVGDocument>?) = load("CGSVGDocumentCreateFromData")
var CGContextDrawSVGDocument: (@convention(c) (CGContext?, CGSVGDocument?) -> Void) = load("CGContextDrawSVGDocument")
var CGSVGDocumentGetCanvasSize: (@convention(c) (CGSVGDocument?) -> CGSize) = load("CGSVGDocumentGetCanvasSize")

typealias ImageWithCGSVGDocument = @convention(c) (AnyObject, Selector, CGSVGDocument) -> UIImage
var ImageWithCGSVGDocumentSEL: Selector = NSSelectorFromString("_imageWithCGSVGDocument:")

let CoreSVG = dlopen("/System/Library/PrivateFrameworks/CoreSVG.framework/CoreSVG", RTLD_NOW)

func load<T>(_ name: String) -> T {
    unsafeBitCast(dlsym(CoreSVG, name), to: T.self)
}

public class SVG {

    deinit { CGSVGDocumentRelease(document) }

    let document: CGSVGDocument

    public convenience init?(_ value: String) {
        guard let data = value.data(using: .utf8) else { return nil }
        self.init(data)
    }

    public init?(_ data: Data) {
        guard let document = CGSVGDocumentCreateFromData(data as CFData, nil)?.takeUnretainedValue() else { return nil }
        guard CGSVGDocumentGetCanvasSize(document) != .zero else { return nil }
        self.document = document
    }

    public var size: CGSize {
        CGSVGDocumentGetCanvasSize(document)
    }

    public func image() -> UIImage? {
        let ImageWithCGSVGDocument = unsafeBitCast(UIImage.self.method(for: ImageWithCGSVGDocumentSEL), to: ImageWithCGSVGDocument.self)
        let image = ImageWithCGSVGDocument(UIImage.self, ImageWithCGSVGDocumentSEL, document)
        return image
    }

    public func draw(in context: CGContext) {
        draw(in: context, size: size)
    }

    public func draw(in context: CGContext, size target: CGSize) {

        var target = target

        let ratio = (
            x: target.width / size.width,
            y: target.height / size.height
        )

        let rect = (
            document: CGRect(origin: .zero, size: size), ()
        )

        let scale: (x: CGFloat, y: CGFloat)

        if target.width <= 0 {
            scale = (ratio.y, ratio.y)
            target.width = size.width * scale.x
        } else if target.height <= 0 {
            scale = (ratio.x, ratio.x)
            target.width = size.width * scale.y
        } else {
            let min = min(ratio.x, ratio.y)
            scale = (min, min)
            target.width = size.width * scale.x
            target.height = size.height * scale.y
        }

        let transform = (
            scale: CGAffineTransform(scaleX: scale.x, y: scale.y),
            aspect: CGAffineTransform(translationX: (target.width / scale.x - rect.document.width) / 2, y: (target.height / scale.y - rect.document.height) / 2)
        )

        context.translateBy(x: 0, y: target.height)
        context.scaleBy(x: 1, y: -1)
        context.concatenate(transform.scale)
        context.concatenate(transform.aspect)

        CGContextDrawSVGDocument(context, document)
    }
}
