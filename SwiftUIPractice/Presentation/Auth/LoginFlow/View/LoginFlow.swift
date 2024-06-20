//
//  LoginFlow.swift
//  Yappetizer
//
//  Created by Harish Garg on 11/02/24.
//

import SwiftUI
import Stripe

struct LoginFlowApp: View {
    
    @StateObject var userStateViewModel = UserStateViewModel()
    
    var body: some View {
        NavigationView{
            ApplicationSwitcher()
        }
        .navigationViewStyle(.stack)
        .environmentObject(userStateViewModel)
    }
}

struct ApplicationSwitcher: View {
    
    @EnvironmentObject var vm: UserStateViewModel
    
    var body: some View {
        
        if (UserDefaultsManager.isLoggedIn ?? false) {
            BaseView()
        } else {
            NewLoginScreen()
        }
    }
}
