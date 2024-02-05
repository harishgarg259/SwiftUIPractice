//
//  DetailView.swift
//  SwiftUIPractice
//
//  Created by Harish Garg on 22/01/24.
//

import SwiftUI

struct ProfileView: View {
    
    @Binding var showMenu: Bool

    var body: some View {
        VStack {
            Text("This is Profile view")
        }
        .navigationTitle("My Profile")
    }
}

#Preview {
    ProfileView(showMenu: .constant(true))
}
