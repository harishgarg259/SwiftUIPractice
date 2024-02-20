//
//  NewLoginScreen.swift
//  Yappetizer
//
//  Created by Teja Sree Marthy on 2/20/24.
//

import SwiftUI

struct NewLoginScreen: View {
    @State var emailId = ""
    @State var password = ""
    @Namespace var animation
    @State var transition: Int? = 0
    
    @State var show = true
    @State private var showForget = false
    @State private var loading = false
    @State var dontHaveAct = "Don't have an account?"
    @State var forgotPassword = "Forgot Password?"
    
    @EnvironmentObject var settings: UserStateViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical,showsIndicators: false) {
                VStack(alignment:.leading) {
                    Image("Logo-new", bundle: nil)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(50)
                    
                    Text("Login")
                        .fontWeight(.heavy)
                        .padding(.leading,20)
                        .font(.system(size: 32, weight: .heavy))
                        .foregroundColor(.primary)
                        
                    
                    Text("Please sign in to continue")
                        .fontWeight(.semibold)
                        .padding(.leading,20)
                        .padding(.bottom,20)
                        .foregroundColor(.gray)
                    
                    VStack(spacing:10) {
                        CustomTextField(image: "envelope", title: "EMAIL", value: $emailId,animation: animation)
                            .padding(.top,10)
                        
                        CustomTextField(image: "lock", title: "PASSWORD", value: $password,animation: animation)
                            .padding(.top,5)
                            .padding(.bottom,10)
                        
                        Button(action: {
                            self.loading = true
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0){
                                self.loading = false
                                settings.isLoggedIn = true
                            }
                        }, label: {
                            Text("LOGIN")
                                .font(.headline)
                                .padding()
                                .padding(.horizontal,100)
                                .cornerRadius(10)
                        })
                        .padding(.top,30)
                        .buttonStyle(.borderedProminent)
                        .shadow(color: .themeColor,radius: 2)
                        .disabled((password.count < 8) || (emailId.textFieldValidatorEmail() == false))
                        
                    }.padding()
                    //Show Forgot Password
                    ShowHyperLinkView(displayText: $forgotPassword, show: $show)
                }
            }
            .padding(.horizontal)
            
            //Show SignUp Option
            ShowHyperLinkView(displayText: $dontHaveAct, show: $show)
        }
    }
}

#Preview {
    NewLoginScreen()
}

struct ShowHyperLinkView: View {
    
    @Binding var displayText : String
    @Binding var show : Bool
    
    var body: some View {
        HStack(spacing: 8){
            if displayText.elementsEqual("Forgot Password?") {
                Spacer()
                NavigationLink(displayText) {
                    ForgetPasssword()
                }
                
            }else {
                Text(displayText)
                    .fontWeight(.heavy)
                    .foregroundColor(.gray)
                
                NavigationLink("SignUp") {
                    Register()
                }
            }
        }
    }
}
