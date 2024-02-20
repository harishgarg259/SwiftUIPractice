//
//  HomeScreen.swift
//  Yappetizer
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
    @State private var showForget = false
    @State private var loading = false
    
    @EnvironmentObject var settings: UserStateViewModel

    var body: some View {
        NavigationStack{
            
            ZStack {
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
                                self.loading = true
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0){
                                    self.loading = false
                                    settings.isLoggedIn = true
                                }
                            } label: {
                                Text("Login")
                                    .frame(maxWidth: .infinity)
                                    .fontWeight(.bold)
                            }
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)
                            .shadow(color: .themeColor,radius: 2)
                            .disabled((password.count < 8) || (email.textFieldValidatorEmail() == false))
                            
                            
                            HStack(spacing: 8){
                                
                                Spacer()
                                
                                Button(action: {
                                    self.showForget = true
                                    
                                }, label: {
                                    Text("Forget Password?")
                                        .fontWeight(.heavy)
                                        .foregroundColor(.themeColor)
                                })
                                .navigationDestination(isPresented: $showForget) {
                                    //ForgetPasssword(show: $showForget)
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
                                .foregroundColor(.themeColor)
                        })
                        .navigationDestination(isPresented: $show) {
                            //Register(show: $show)
                        }
                    }
                }
                
                if loading {
                    ProgressView()
                        .scaleEffect(3)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.5))
                }
            }
        }
        .tint(.themeColor)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    LoginScreen()
}
