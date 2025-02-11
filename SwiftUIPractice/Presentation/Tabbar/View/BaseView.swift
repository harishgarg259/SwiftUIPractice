//
//  BaseView.swift
//  Yappetizer
//
//  Created by Harish Garg on 03/02/24.
//

import SwiftUI

enum Tab {
       case home
       case cart
       case settings
   }

struct BaseView: View {
    
    @State var showMenu: Bool = false
    @State private var currentTab: Tab = .home

    // Offset for Both Drag Gestures and showing Menu.
    @State var offset: CGFloat = 0
    @State var lastStoredOffset: CGFloat = 0
    
    @GestureState var gestureOffset: CGFloat = 0
    
    @EnvironmentObject var vm: UserStateViewModel

    @StateObject var cartItems = CartViewModel()
    
    private let sideBarWidth = UIScreen.main.bounds.width - 90
    
    init() {
        UITabBar.appearance().isHidden = false
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                NavigationStack {
                    HomeScreen()
                        .environmentObject(cartItems)
                }
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Tab.home)
                .environment(\.currentTab, $currentTab)
                NavigationStack {
                    CartView(viewModel: cartItems)
                }
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }.badge(cartItems.cartArray.count)
                .tag(Tab.cart)
                .environment(\.currentTab, $currentTab)
                NavigationStack {
                    ProfileView(userModel: UserProfileViewModel())
                }
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
                .tag(Tab.settings)
                .environment(\.currentTab, $currentTab)
            }.accentColor(.themeColor)
        }
        .frame(width: getRect().width)
        .overlay(
            Rectangle()
                .fill(
                    // offset: 300 / 300 = 1
                    // 1 / 5 = 0.2
                    Color.primary.opacity( (offset / sideBarWidth) / 5.0 )
                )
                .ignoresSafeArea(.container, edges: .all)
                .onTapGesture {
                    showMenu.toggle()
                }
            
        )
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}


struct CurrentTabKey: EnvironmentKey {
    static var defaultValue: Binding<Tab> = .constant(.home)
}

extension EnvironmentValues {
    var currentTab: Binding<Tab> {
            get { self[CurrentTabKey.self] }
            set { self[CurrentTabKey.self] = newValue }
        }
}
