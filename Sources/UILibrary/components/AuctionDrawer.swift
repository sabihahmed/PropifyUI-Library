import SwiftUI

// MARK: - Card State

public enum CatalogueCardState {
    case normal
    case selected
}

// MARK: - Drawer Item Model

public struct DrawerItem: Identifiable {
    public let id : Int
    public let icon: String
    public let title: String
    public let subtitle: String
    public let estimate: String
    public let status: PropertyStatus
    
    public init(id: Int,
                icon: String,
                title: String,
                subtitle: String,
                estimate: String,
                status: PropertyStatus) {
        self.id = id
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.estimate = estimate
        self.status = status
        
    }
}
    
    // MARK: - Drawer View
    
    public struct DrawerView: View {
        @Binding public var isOpen: Bool
        @State private var selectedItemId: Int?
        public let activeItems: [DrawerItem]// ✅ MAIN LIST
        public let endedItems: [DrawerItem]
        
        
        
        public let width: CGFloat
        
        public init(
            isOpen: Binding<Bool>,
            width: CGFloat = 350,
            activeItems: [DrawerItem],
            endedItems: [DrawerItem]
            
        ) {
            self._isOpen = isOpen
            self.width = width
            self.activeItems = activeItems
            self.endedItems = endedItems
        }
        
        public var body: some View {
            ZStack(alignment: .leading) {
                if isOpen {
                    ZStack(alignment: .topTrailing) {
                        
                        Color.black.opacity(0.15)
                            .ignoresSafeArea()
                            .onTapGesture { closeDrawer() }
                        
                        Button(action: { closeDrawer() }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .padding(12)
                        }
                        .padding(.top, 60)
                        .padding(.trailing, 20)
                        
                        HStack(spacing: 0) {
                            VStack(alignment: .leading, spacing: 0) {
                                
                                // Header
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Auction Catalogue")
                                        .font(.poppinsBold(size: 20))
                                    
                                    Text("\(activeItems.count) Auctions") // ✅ MAIN COUNT
                                        .font(.poppinsRegular(size: 12))
                                        .foregroundColor(.secondary)
                                }
                                .padding(.top, 80)
                                .padding(.horizontal, 20)
                                .padding(.bottom, 20)
                                
                                // Split items
                                //                            let visibleItems = Array(items.prefix(3))
                                //                            let moreItems = Array(items.dropFirst(3))
                                
                                // List
                                ScrollView {
                                    VStack(spacing: 16) {
                                        
                                        // ✅ ACTIVE ITEMS
                                        ForEach(activeItems) { item in
                                            CatalogueCards(
                                                lotId: "\(item.id)",
                                                title: item.title,
                                                subTitle: item.subtitle,
                                                estimate: item.estimate,
                                                status: item.status,
                                                state: selectedItemId == item.id ? .selected : .normal
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()) {
                                                    selectedItemId = item.id
                                                }
                                            }
                                        }
                                        
                                        // ✅ ENDED AUCTIONS (NOW IN CORRECT POSITION)
                                        if !endedItems.isEmpty {
                                            CatalogueDropdownView(items: endedItems)
                                                .padding(.top, 10)
                                        }
                                    }
                                    .padding(.top, 10)
                                    .padding(.horizontal, 20)
                                }
                                
                                
                                
                                Spacer()
                            }
                            .frame(width: width)
                            .background(Color.white)
                            .transition(.move(edge: .leading))
                            
                            Spacer()
                        }
                    }
                    .transition(.opacity)
                    .zIndex(2)
                }
            }
            .ignoresSafeArea()
            .animation(.spring(response: 0.4, dampingFraction: 0.85), value: isOpen)
        }
        
        public func closeDrawer() {
            withAnimation(.spring()) {
                isOpen = false
            }
        }
    }
    
    // MARK: - Catalogue Card
    
    public struct CatalogueCards: View {
        public var lotId: String
        public var title: String
        private var subTitle: String
        public var estimate: String
        public var status: PropertyStatus
        public var state: CatalogueCardState
        
        public init(
            lotId: String,
            title: String,
            subTitle: String,
            estimate: String,
            status: PropertyStatus,
            state: CatalogueCardState = .normal
        ) {
            self.lotId = lotId
            self.title = title
            self.estimate = estimate
            self.status = status
            self.state = state
            self.subTitle = subTitle
        }
        
        public var body: some View {
            HStack(alignment: .center, spacing: 10) {
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    HStack(spacing: 4) {
                        //Text(lotId)
                        Text(title)
                    }
                    .font(.poppinsBold(size: 14))
                    .foregroundColor(state == .selected ? .ColorsTextPrimary : .ColorsTextSecondary)
                    
                    HStack {
                        Text("$: \(subTitle)")
                            .font(.poppinsBold(size: 14))
                            .foregroundColor(.secondary)
                        
                        StatusChip(status: status)
                    }
                }
                
                Spacer()
                
                Image(state == .selected ? "arrowRight" : "arrowRight2nd", bundle: .module)
                    .foregroundColor(state == .selected ? .ColorsButtonPrimary : .ColorsTextSecondary)
                    .padding(.top, 4)
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        state == .selected ? Color.ColorsButtonPrimary : Color.ColorsStrokeDefault,
                        lineWidth: state == .selected ? 2 : 1
                    )
            )
        }
    }
    
    // MARK: - Dropdown
    
    public struct CatalogueDropdownView: View {
        
        @State private var isExpanded: Bool = false
        public let items: [DrawerItem]
        
        public init(items: [DrawerItem]) {
            self.items = items
        }
        
        public var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                
                Button {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        isExpanded.toggle()
                    }
                } label: {
                    HStack {
                        Text("Ended Auctions (\(items.count))")
                            .font(.poppinsBold(size: 16))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .rotationEffect(.degrees(isExpanded ? 180 : 0))
                    }
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                }
                
                if isExpanded {
                    VStack(spacing: 16) {
                        ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                            CatalogueCards(
                                lotId: "\(item.id)",
                                title: item.title,
                                subTitle: item.subtitle,
                                estimate: item.estimate,
                                status: item.status,
                                state: .normal
                            )
                            .opacity(isExpanded ? 1 : 0)
                            .offset(y: isExpanded ? 0 : -10)
                            .animation(
                                .easeOut(duration: 0.25)
                                .delay(Double(index) * 0.05),
                                value: isExpanded
                            )
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Demo Content View
    
    public struct ContentView: View {
        @State public var isDrawerOpen: Bool = true
        
        public init() {}
        
        public var body: some View {
            ZStack {
                NavigationView {
                    Text("Main Content")
                        .navigationTitle("Dashboard")
                }
                
                DrawerView(
                    isOpen: $isDrawerOpen,
                    activeItems: [
                        DrawerItem(id: 11, icon: "1", title: "Luxury Villa", subtitle: "50,000", estimate: "45% below Average", status: .active),
                        DrawerItem(id: 11, icon: "1", title: "Luxury Villa", subtitle: "50,000", estimate: "45% below Average", status: .active),
                        DrawerItem(id: 11, icon: "1", title: "Luxury Villa", subtitle: "50,000", estimate: "45% below Average", status: .active),
                        DrawerItem(id: 11, icon: "1", title: "Luxury Villa", subtitle: "50,000", estimate: "45% below Average", status: .active)
                    ],
                    endedItems: [
                        DrawerItem(id: 11, icon: "1", title: "Luxury Villa", subtitle: "50,000", estimate: "45% below Average", status: .boughtIn),
                        DrawerItem(id: 11, icon: "1", title: "Luxury Villa", subtitle: "50,000", estimate: "45% below Average", status: .boughtIn),
                        DrawerItem(id: 11, icon: "1", title: "Luxury Villa", subtitle: "50,000", estimate: "45% below Average", status: .boughtIn)
                    ]
                )
            }
        }
    }

// MARK: - Fonts

extension Font {
    public static func poppinsBold(size: CGFloat) -> Font { .system(size: size, weight: .bold) }
    public static func poppinsRegular(size: CGFloat) -> Font { .system(size: size, weight: .regular) }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
