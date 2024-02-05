//
//  SideMenu.swift
//  SwiftUIPractice
//
//  Created by Harish Garg on 03/02/24.
//

import SwiftUI

struct SideMenu: View {
    
    @Binding var showMenu: Bool
    
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
                        
                        TabButton(title: "My Profile", image: "logo")
                        TabButton(title: "Blog", image: "logo")
                        TabButton(title: "About Us", image: "logo")
                        TabButton(title: "Contact Us", image: "logo")
                        TabButton(title: "Log Out", image: "logo")

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
    func TabButton(title: String, image: String) -> some View {
        
        NavigationLink {
            Text("\(title) View")
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
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

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
