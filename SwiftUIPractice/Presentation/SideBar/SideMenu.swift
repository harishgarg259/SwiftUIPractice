//
//  SideMenu.swift
//  Yappetizer
//
//  Created by Harish Garg on 03/02/24.
//

import SwiftUI

struct SideMenu: View {
    
    @State private var isLoading = true
    @Binding var showMenu: Bool
    @State private var showAlert = false
    @State var logout = false
    @EnvironmentObject var settings: UserStateViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            // Profile
            VStack(alignment: .leading, spacing: 2) {
                Text("Harish")
                    .font(.title.bold())
                Text("harishgarg259@gmail.com")
                    .font(.callout)
                    .padding(.bottom, 15)
            }
            .padding(.horizontal)
            .padding(.leading)
            Divider()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    VStack(alignment: .leading, spacing: 40) {
                        
                        TabButton(title: "My Profile", image: "person.crop.circle", type: .None)
                        TabButton(title: "Blog", image: "note.text", type: .Blog)
                        TabButton(title: "About Us", image: "exclamationmark.bubble", type: .AboutUS)
                        TabButton(title: "Contact Us", image: "phone.connection", type: .ContactUS)
                    }
                    .padding()
                    .padding(.leading)
                    .padding(.top, 10)
                    
                    Spacer()
                    
                    Divider()
                }
                
                Image("menuBG")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }
            
            // Footer
            Divider()
                .padding(.bottom, 12)
            HStack(spacing: 12) {
                Image(systemName: "arrow.forward.square")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height: 20)
                    .tint(.themeColor)
                    .padding(.leading,12)
                
                Button() {
                    showAlert = true
                } label: {
                    Text("Logout")
                        .fontWeight(.medium)
                }
                .alert(isPresented:$showAlert) {
                    Alert(
                        title: Text("Are you sure you want to logout?"),
                        primaryButton: .destructive(Text("Logout")) {
                            settings.isLoggedIn = false
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .foregroundColor(.themeColor)
            .padding([.leading, .bottom])
            
        }
        .padding(.vertical)
        .frame(width: getRect().width - 90)
        .background(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .ignoresSafeArea(.container, edges: .bottom)
    }
    
    @ViewBuilder
    func TabButton(title: String, image: String, type: SafariURL) -> some View {
        
        NavigationLink {
            
            if type == .None{
                ProfileView()
            }else
            {
                WebView(isLoading: $isLoading, type: type)
                    .ignoresSafeArea()
                    .navigationTitle(title)
                    .navigationBarTitleDisplayMode(.inline)
                    .tint(.themeColor)
                if isLoading{
                    ProgressView()
                }
            }
        } label: {
            HStack(spacing: 12) {
                Image(systemName: image)
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height: 20)
                    .tint(.themeColor)
                
                Text(title)
                    .fontWeight(.medium)
            }
            .foregroundColor(.themeColor)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
