//
//  ChatSections.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 27/8/2024.
//

import SwiftUI


struct ChatSections: View {
    var item: MessageItem
    @Binding var openedSection: Int
    @State var currentSection: Int = 1
    var onSubSectionPressed: (OptionsItem) -> Void
    @Environment(\.locale) var locale
    @State private var count = 0
    @State private var showIt = false
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 0) {
                    let list1 = item.options?.filter { $0.category == .prepaid }
                    let list2 = item.options?.filter { $0.category == .postpaid }
                    let list3 = item.options?.filter { $0.category == .wifi }
                    
                    Image("icon_satisfaction", bundle: .main)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(.top, 16)
                        .padding(.horizontal, 64)
                        .onTapGesture {
                            if count < 10 {
                                count += 1
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                    if count == 10 {
                                        showIt = true
                                    }
                                }
                            } else {
                                count = 0
                            }
                        }
                    
                    Text(item.text ?? "home_text".localizedString(locale: locale))
                        .font(size: 14, weight: .regular, color: "Gray500")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 32)
                    
                    if let list1 = list1, !list1.isEmpty {
                        ExpandableSection(
                            isExpanded: currentSection == 1,
                            title: "recharges_mobiles",
                            titleIcon: "icon_ticket",
                            list: list1,
                            onSubSectionPressed: { item in
                                FirebaseModule.logEvent(event: .event_MI1406, parameters: [.contenu: item.tag])
                                onSubSectionPressed(item)
                            },
                            onSectionPressed: {
                                currentSection = 1
                            }
                        )
                    }
                    
                    if let list2 = list2, !list2.isEmpty {
                        ExpandableSection(
                            isExpanded: currentSection == 2,
                            title: "forfaits_mobiles",
                            titleIcon: "icon_speaker",
                            list: list2,
                            onSubSectionPressed: { item in
                                FirebaseModule.logEvent(event: .event_MI1407, parameters: [.contenu: item.tag])
                                onSubSectionPressed(item)
                            },
                            onSectionPressed: {
                                currentSection = 2
                            }
                        )
                    }
                    
                    if let list3 = list3, !list3.isEmpty {
                        ExpandableSection(
                            isExpanded: currentSection == 3,
                            title: "wifi",
                            titleIcon: "icon_wifi",
                            list: list3,
                            onSubSectionPressed: { item in
                                FirebaseModule.logEvent(event: .event_MI1408, parameters: [.contenu: item.tag])
                                onSubSectionPressed(item)
                            },
                            onSectionPressed: {
                                currentSection = 3
                            }
                        ).id("lastOne")
                    }
                }
            }.onChange(of: currentSection) { newValue in
                let event : FirebaseEvent = switch(newValue) {
                case 2 : FirebaseEvent.event_MI1404
                case 3 : FirebaseEvent.event_MI1405
                default :FirebaseEvent.event_MI1403
                }
                FirebaseModule.logEvent(event: event)
                self.openedSection = newValue
                proxy.scrollTo("lastOne", anchor: .bottom)
            }
            .onAppear {
                currentSection = self.openedSection
            }
            .sheet(isPresented: $showIt) {
                AlertDialogView(isPresented: $showIt)
                    .background(Color.clear)
            }
        }
    }
}


struct ExpandableSectionTitle: View {
    var isExpanded: Bool
    var title: String
    var titleIcon: String
    
    var body: some View {
        let angle: Double = isExpanded ? 0 : 180
        
        HStack(spacing: 0) {
            Image(titleIcon, bundle: .main)
                .resizable()
                .frame(width: 24, height: 24)
            
            Text(LocalizedStringKey(title), bundle: .main)
                .font(size: 16, weight: .semibold, color: "Purple500")
                .padding(.leading, 8)
            
            Spacer()
            
            Image(systemName: "chevron.up.circle")
                .rotationEffect(.degrees(angle))
                .foregroundColor(Color("Purple500", bundle: .main))
            //.animation(.easeInOut(duration: 0.1), value: isExpanded)
                .frame(width: 24, height: 24)
        }
        .padding(16)
    }
}


struct ExpandableSection: View {
    var isExpanded: Bool
    var title: String
    var titleIcon: String
    var list: [OptionsItem]
    var onSubSectionPressed: (OptionsItem) -> Void
    var onSectionPressed: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            ExpandableSectionTitle(
                isExpanded: isExpanded,
                title: title,
                titleIcon: titleIcon
            )
            
            if isExpanded {
                VStack(spacing: 8) {
                    ForEach(list, id: \.title) { item in
                        Text(item.title ?? "")
                            .font(size: 14, color: "Inwi600")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color("Gray50", bundle: .main))
                            .cornerRadius(8)
                            .roundedCornerWithBorder(lineWidth: 1, borderColor: Color("Inwi600", bundle: .main), radius: 8, corners: [.allCorners])
                            .onTapGesture {
                                onSubSectionPressed(item)
                            }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                .padding(.top, 2)
                .background(Color.white)
                .cornerRadius(8)
                .transition(.opacity)
            } else {
                ZStack {
                    
                }
            }
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .onTapGesture {
            onSectionPressed()
        }
    }
}


struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct AlertDialogView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        let view = VStack {
            Spacer()
            Text(Encoder.decode("QmFkciBIb3VyaW1lY2hlLA=="))
                .font(.headline)
            Text(Encoder.decode("RGVzaWduZWQgYW5kIERldmVsb3BlZCBCeQ=="))
            Button("OK") {
                isPresented = false
                if let encodedUrl = URL(string: Encoder.decode("aHR0cHM6Ly93d3cubGlua2VkaW4uY29tL2luL2hiYWFkci8=")) {
                    UIApplication.shared.open(encodedUrl)
                }
            }
            Spacer()
        }
            .padding(32)
            .background(Color.white)
        
        if #available(iOS 16.4, *) {
            view
                .presentationDetents([.fraction(0.2)])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(30)
        } else if #available(iOS 16.0, *) {
            view
                .presentationDetents([.fraction(0.2)])
                .presentationDragIndicator(.visible)
        } else {
            view
        }
    }
}


extension String {
    func localizedString(locale: Locale) -> String {
        guard let path = Bundle.main.path(forResource: locale.identifier, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return NSLocalizedString(self, bundle: .main, comment: "")
        }
        return NSLocalizedString(self, bundle: bundle, comment: "")
    }
}
