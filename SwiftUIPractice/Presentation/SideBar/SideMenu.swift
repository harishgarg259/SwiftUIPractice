//
//  SideMenu.swift
//  SwiftUIPractice
//
//  Created by Harish Garg on 03/02/24.
//

import SwiftUI

struct SideMenu: View {
    
    @State private var isLoading = true
    @Binding var showMenu: Bool
    @State private var showAlert = false

    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            // Profile
            VStack(alignment: .leading, spacing: 10) {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 65, height: 65)
                    .clipShape(Circle())
                Text("Harish")
                    .font(.title.bold())
                Text("harishgarg259@gmail.com")
                    .font(.callout)
            }
            .padding(.horizontal)
            .padding(.leading)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    VStack(alignment: .leading, spacing: 40) {
                        
                        TabButton(title: "My Profile", image: "logo", type: .None)
                        TabButton(title: "Blog", image: "logo", type: .Blog)
                        TabButton(title: "About Us", image: "logo", type: .AboutUS)
                        TabButton(title: "Contact Us", image: "logo", type: .ContactUS)
                        TabButton(title: "Log Out", image: "logo", type: .None)
                            .alert(Text("Are you sure you want to logout?"),isPresented: $showAlert) {
                                    Button("Cancel", role: .cancel) {}
                                    Button("OK") {
                                            // Handle the acknowledgement.
                                    }
                            }
                    }
                    .padding()
                    .padding(.leading)
                    .padding(.top, 35)
                    
                    Spacer()
                    
                    Divider()
                }
            }
            
            // Footer
            VStack(spacing: 0) {
                
                Divider()
                
                HStack {
                    Button {
                        
                    } label: {
                        Image("eye.trianglebadge.exclamationmark")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 22, height: 22)
                        
                        Spacer()
                    }
                }
                .padding([.horizontal, .top, .bottom])
            }
            
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(width: getRect().width - 90)
        .frame(maxHeight: .infinity)
        .background(
            Color.primary
                .opacity(0.08)
                .ignoresSafeArea(.container, edges: .vertical)
        )
        .frame(maxWidth: .infinity, alignment: .leading)
        .ignoresSafeArea(.container, edges: .bottom)
    }
    
    @ViewBuilder
    func TabButton(title: String, image: String, type: SafariURL) -> some View {
        
        if title == "Log Out"{
            
        }else{
            NavigationLink {
                WebView(isLoading: $isLoading, type: type)
                    .ignoresSafeArea()
                    .navigationTitle(title)
                    .navigationBarTitleDisplayMode(.inline)
                if isLoading{
                    ProgressView()
                }
            } label: {
                HStack(spacing: 13) {
                    Image(image)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 22, height: 22)
                    
                    Text(title)
                }
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
