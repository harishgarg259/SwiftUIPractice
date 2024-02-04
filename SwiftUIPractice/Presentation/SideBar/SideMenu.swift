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
                Text("@harish")
                    .font(.callout)
                
                HStack(spacing: 12) {
                    
                    Button {
                        
                    } label: {
                        
                        Label {
                            Text("Followers")
                                .font(.caption)
                        } icon: {
                            Text("1.5M")
                                .fontWeight(.bold)
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        
                        Label {
                            Text("following")
                                .font(.caption)
                        } icon: {
                            Text("1.2k")
                                .fontWeight(.bold)
                        }
                    }
                }
                .foregroundColor(.primary)
                
            }
            .padding(.horizontal)
            .padding(.leading)
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    VStack(alignment: .leading, spacing: 40) {
                        
                        TabButton(title: "Profile", image: "logo")
                        
                        TabButton(title: "Lists", image: "logo")
                        
                        TabButton(title: "Bookmarks", image: "logo")
                        
                        TabButton(title: "Moments", image: "logo")
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
