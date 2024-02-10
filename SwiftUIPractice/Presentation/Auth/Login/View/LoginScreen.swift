//
//  HomeScreen.swift
//  SwiftUIPractice
//
//  Created by Harish Garg on 04/02/24.
//

import SwiftUI

struct LoginScreen: View {
    
    @State var email = ""
    @State var password = ""
    @Namespace var animation
    @State var transition: Int? = 0
    
    @State var show = false
    @State var showForget = false
    
    var body: some View {
        NavigationStack{
            
            VStack {
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack{
                        
                        Image("Logo-new", bundle: nil)
                            .padding(.top, 80)
                            .padding(.bottom, 40)
                        
                        HStack{
                            
                            VStack(alignment: .leading, spacing: 10) {
                                
                                Text("Login")
                                    .font(.system(size: 32, weight: .heavy))
                                // for Dark Mode Adoption...
                                    .foregroundColor(.primary)
                                
                                Text("Please sign in to continue")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer(minLength: 0)
                        }
                        
                        CustomTextField(image: "envelope", title: "EMAIL", value: $email,animation: animation)
                            .padding(.top,10)
                        
                        CustomTextField(image: "lock", title: "PASSWORD", value: $password,animation: animation)
                            .padding(.top,5)
                            .padding(.bottom,20)
                        
                        Button {
                        } label: {
                            Text("Login")
                                .frame(maxWidth: .infinity)
                                .fontWeight(.bold)
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .shadow(color: .themeColor,radius: 2)
                        
                        
                        HStack(spacing: 8){
                            
                            Spacer()
                            
                            Button(action: {
                                self.showForget = true
                            }, label: {
                                Text("Forget Password?")
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.themeColor)
                            })
                            .navigationDestination(isPresented: $showForget) {
                                ForgetPasssword(show: $showForget)
                            }
                        }
                        .padding(.top, 10)
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                })
                HStack(spacing: 8){
                    
                    Text("Don't have an account?")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    
                    Button(action: {
                        self.show = true
                    }, label: {
                        Text("sign up")
                            .fontWeight(.heavy)
                            .foregroundColor(Color.themeColor)
                    })
                    .navigationDestination(isPresented: $show) {
                        Register(show: $show)
                    }
                }
            }
        }
        .tint(Color.themeColor)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    LoginScreen()
}
