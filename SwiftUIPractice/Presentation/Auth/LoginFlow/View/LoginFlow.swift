//
//  LoginFlow.swift
//  Yappetizer
//
//  Created by Harish Garg on 11/02/24.
//

import SwiftUI

@main
struct LoginFlowApp: App {
    
    @StateObject var userStateViewModel = UserStateViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ApplicationSwitcher()
            }
            .navigationViewStyle(.stack)
            .environmentObject(userStateViewModel)
        }
    }
}

struct ApplicationSwitcher: View {
    
    @EnvironmentObject var vm: UserStateViewModel
    
    var body: some View {
        if (vm.isLoggedIn) {
            BaseView()
        } else {
            LoginScreen()
        }
    }
}
