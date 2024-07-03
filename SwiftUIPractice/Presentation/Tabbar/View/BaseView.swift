//
//  BaseView.swift
//  Yappetizer
//
//  Created by Harish Garg on 03/02/24.
//

import SwiftUI

struct BaseView: View {
    
    @State var showMenu: Bool = false
    @State var currentTab = "Home"
    
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
                .tag("Home")
                NavigationStack {
                    CartView(cartProducts: cartItems)
                }
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }.badge(cartItems.cartProduct.count)
                .tag("Cart")
                NavigationStack {
                    ProfileView(userModel: UserProfileViewModel())
                }
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
                .tag("Profile")
            }
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
