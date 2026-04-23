import SwiftUI

// MARK: - Model
public struct DrawerItem: Identifiable {
    public let id = UUID()
    public let icon: String
    public let title: String
    
    public init(icon: String, title: String) {
        self.icon = icon
        self.title = title
    }
}

// MARK: - Drawer View
public struct DrawerView: View {
    
    @Binding var isOpen: Bool
    
    private let width: CGFloat
    private let items: [DrawerItem]
    
    public init(
        isOpen: Binding<Bool>,
        width: CGFloat = 350,
        items: [DrawerItem]
    ) {
        self._isOpen = isOpen
        self.width = width
        self.items = items
    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            
            // Dim background
            if isOpen {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isOpen = false
                        }
                    }
                    .transition(.opacity)
            }
            
            // Drawer
            VStack(alignment: .leading, spacing: 12) {
                
                VStack(alignment: .leading){
                    Text("Auction Catalougue")
                        .padding(.top,50)
                        .font(.poppinsBold(size: 20))
                    
                    Text("4 Auctions")
                        .font(.poppinsRegular(size: 12))
                        .foregroundColor(.ColorsTextSecondary)
                }.padding(.bottom,10)
                    

                
                
                ForEach(items) { item in
                    CatalogueCards(
                        lotId: "Lot 1:",
                        title: "Luxury Villa",
                        estimate: "3.5M",
                        status: .upcoming
                    )
                    
                }
                
                CatalogueDropdownView(
                    items: items
                )
                
                Spacer()
            }
            .padding()
            .frame(width: width)
            .frame(maxHeight: .infinity)
            .background(Color.white)
            .ignoresSafeArea()
            .offset(x: isOpen ? 0 : -width)
        }
    }
}

// MARK: - Menu Item
public struct DrawerMenuItem: View {
    
    var icon: String
    var text: String
    
    public init(icon: String, text: String) {
        self.icon = icon
        self.text = text
    }
    
    public var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 30)
            
            Text(text)
                .font(.headline)
            
            Spacer()
        }
        .padding()
    }
}

// MARK: - Main Content View
struct ContentView: View {
    
    @State private var isDrawerOpen: Bool
    
    private let isPreview: Bool
    
    init(isDrawerOpen: Bool = false, isPreview: Bool = false) {
        self._isDrawerOpen = State(initialValue: isDrawerOpen)
        self.isPreview = isPreview
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            NavigationView {
                VStack {
                    Text("Main App Content")
                        .font(.title)
                        .foregroundColor(.gray)
                }
                .navigationTitle("Home")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        
                        // Hide button in preview if you want (optional)
                        if !isPreview {
                            Button {
                                withAnimation(.spring()) {
                                    isDrawerOpen.toggle()
                                }
                            } label: {
                                Image(systemName: "line.3.horizontal")
                            }
                        }
                    }
                }
            }
            
            DrawerView(
                isOpen: $isDrawerOpen,
                items: [
                    DrawerItem(icon: "gear", title: "Settings"),
                    DrawerItem(icon: "bell", title: "Notifications"),
                    DrawerItem(icon: "questionmark.circle", title: "Help")
                ]
            )
        }
    }
}
import SwiftUI


public struct CatalogueCards: View {
    public var lotId: String
    public var title: String
    public var estimate: String
    public var status: PropertyStatus
    
    public init(lotId: String,
        title: String,
        estimate: String,
        status: PropertyStatus)
    {
        self.lotId = lotId
        self.title = title
        self.estimate = estimate
        self.status = status
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 10){
            
            VStack(alignment: .leading){
                
                HStack(alignment:.top, spacing: 1){
                    Text(lotId)
                        .font(.poppinsBold(size: 14))
                        .foregroundColor(.ColorsTextPrimary)
                    Text(title)
                        .font(.poppinsBold(size: 14))
                        .foregroundColor(.ColorsTextPrimary)
                        
                }
                
                
                HStack{
                    Text("$: \(estimate)")
                        .foregroundColor(.ColorsTextSecondary)
                    StatusChip(status: status)
                }
                
                
                
            }
            Spacer()
            Image("arrowRight", bundle: .module)
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
                .padding(.horizontal,4)
                .padding(.top,14)


            
            


        } .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .cornerRadius(16)
            .overlay(
            RoundedRectangle(cornerRadius: 16)
            .inset(by: 0.5)
            .stroke(Color.ColorsStrokeDefault, lineWidth: 1)
            )
        
        
        
        
    }
    
}

import SwiftUI

public struct CatalogueDropdownView: View {
    
    @State private var isExpanded: Bool = false
    private let items: [DrawerItem]
    
    public init(items: [DrawerItem]) {
        self.items = items
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            // HEADER
            Button {
                withAnimation(.easeInOut(duration: 0.25)) {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    Text("Auction Catalogue")
                        .font(.poppinsBold(size: 16))
                        .foregroundColor(.ColorsTextPrimary)
                    
                    Spacer()
                    
                    Image("arrowDown", bundle: .module)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .animation(.easeInOut(duration: 0.25), value: isExpanded)
                }
                .padding(.vertical, 8)
            }
            
            // DROPDOWN (NO OFFSET, NO FAKE MOTION)
            VStack(spacing: 8) {
                ForEach(items) { item in
                    CatalogueCards(
                        lotId: "Lot 1",
                        title: item.title,
                        estimate: "3.5M",
                        status: .active
                    )
                }
            }
            .frame(height: isExpanded ? nil : 0, alignment: .top)
            .clipped()
        }
        .animation(.easeIn(duration: 0.2), value: isExpanded)
    }
}

// MARK: - PREVIEW
struct DrawerView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerView(
            isOpen: .constant(true),
            items: [
                DrawerItem(icon: "house", title: "Villa"),
                DrawerItem(icon: "building", title: "Apartment"),
                DrawerItem(icon: "leaf", title: "Farmhouse")
            ]
        )
    }
}
