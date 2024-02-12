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

    private let sideBarWidth = UIScreen.main.bounds.width - 90
    
    init() {
        UITabBar.appearance().isHidden = false
    }
    
    var body: some View {
        
        let sideBarWidth = getRect().width - 90
        
        NavigationStack {
            
            HStack(spacing: 0) {
                SideMenu(showMenu: $showMenu)
                NavigationStack {
                    HomeScreen(showMenu: $showMenu)
                }
                .frame(width: getRect().width)
                .overlay(
                    Rectangle()
                        .fill(
                            // offset: 300 / 300 = 1
                            // 1 / 5 = 0.2
                            Color.primary.opacity( (offset / sideBarWidth) / 5.0 )
                        )
                        .onTapGesture {
                            showMenu.toggle()
                        }
                    
                )
            }
            // maxWidth : sideBarWidth + screenWidth
            .frame(width: sideBarWidth + getRect().width)
            .offset(x: -sideBarWidth / 2)
            .offset(x: offset)
            .gesture(
                DragGesture()
                    .updating($gestureOffset, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onEnded(onEnd(value:))
            )
            .navigationTitle("Yappetizer")
            .navigationBarItems(trailing: trailingBarItems)
            .navigationBarItems(leading: leadingBarItems)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .edgesIgnoringSafeArea(.top)
        .tint(.themeColor)
        .animation(.linear(duration: 0.15), value: offset == 0)
        .onChange(of: showMenu) { newValue in
            if showMenu && offset == 0 {
                offset = sideBarWidth
                lastStoredOffset = offset
            }
            
            if !showMenu && offset == sideBarWidth {
                offset = 0
                lastStoredOffset = 0
            }
        }
        .onChange(of: gestureOffset) { newValue in
            
            if gestureOffset != 0 {
                
                // Dragging width SideBarWidth
                if gestureOffset + lastStoredOffset < sideBarWidth && (gestureOffset + lastStoredOffset) > 0 {
                    
                    offset = lastStoredOffset + gestureOffset
                    
                } else {
                    // sideMenuWidth
                    if gestureOffset + lastStoredOffset < 0 {
                        // Dragging device
                        offset = 0
                    }
                }
            }
        }
    }
    
    var trailingBarItems: some View {
        NavigationLink(destination:
            CartView(showMenu: .constant(false))
        )
        {
            Image(systemName: "cart")
                .font(.system(size: 20))
        }
        .overlay(Badge(count: 8))
    }
    
    var leadingBarItems: some View {
        Button(action: {
            withAnimation {
                showMenu.toggle()
            }
        }) {
            Image(systemName: "list.bullet")
                .font(.system(size: 20))
        }
        .padding(5)
    }
    
    func onEnd(value: DragGesture.Value) {
        
        withAnimation(.spring(duration: 0.15)) {
            
            if value.translation.width > 0 {
                // Dragging>>>
                
                if value.translation.width > sideBarWidth / 2 {
                    
                    offset = sideBarWidth
                    lastStoredOffset = sideBarWidth
                    showMenu = true
                } else {
                    
                    // sideMenu dragging
                    if value.translation.width > sideBarWidth && showMenu {
                        offset = 0
                        showMenu = false
                    } else {
                        // velocity
                        // sideMenu dragging
                        if value.velocity.width > 800 {
                            offset = sideBarWidth
                            showMenu = true
                        } else if showMenu == false {
                            // showSideMenu == false
                            offset = 0
                            showMenu = false
                        }
                    }
                }
            } else {
                // <<<Dragging
                
                if -value.translation.width > sideBarWidth / 2 {
                    offset = 0
                    showMenu = false
                } else {
                    
                    // sideMenu dragging
                    guard showMenu else {
                        return }
                    
                    // sideMenu dragging
                    if -value.velocity.width > 800 {
                        offset = 0
                        showMenu = false
                    } else {
                        offset = sideBarWidth
                        showMenu = true
                    }
                    
                }
            }
        }
        
        lastStoredOffset = offset
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}



// Main Tab View
//                VStack(spacing: 0) {
//                    TabView(selection: $currentTab) {
//                        NavigationStack {
//                            HomeScreen(showMenu: $showMenu)
//                        }
//                        .tabItem {
//                            Label("Home", systemImage: "gear")
//                        }
//                        .tag("Home")
//                        NavigationStack {
//                            CartView(showMenu: $showMenu)
//                        }
//                        .tabItem {
//                            Label("Cart", systemImage: "gear")
//                        }
//                        .tag("Cart")
//                        NavigationStack {
//                            ProfileView(showMenu: $showMenu)
//                        }
//                        .tabItem {
//                            Label("Profile", systemImage: "gear")
//                        }
//                        .tag("Cart")
//                    }
//                }
//                .frame(width: getRect().width)
//                .overlay(
//                    Rectangle()
//                        .fill(
//                            // offset: 300 / 300 = 1
//                            // 1 / 5 = 0.2
//                            Color.primary.opacity( (offset / sideBarWidth) / 5.0 )
//                        )
//                        .ignoresSafeArea(.container, edges: .all)
//                        .onTapGesture {
//                            showMenu.toggle()
//                        }
//
//                )
