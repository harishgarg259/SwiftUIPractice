//
//  NewLoginScreen.swift
//  Yappetizer
//
//  Created by Teja Sree Marthy on 2/20/24.
//

import SwiftUI
import ActivityIndicatorView

struct NewLoginScreen: View {
    @State var emailId = "testing1234@gmail.com"
    @State var password = "testing123"
    @Namespace var animation
    @State var transition: Int? = 0
    
    @State var show = true
    @State var showAlert = false
    @State var showLoadingIndicator = false
    @State private var showForget = false
    @State private var loading = false
    @State var alertMessage: String = ""
    @State var dontHaveAct = "Don't have an account?"
    @State var forgotPassword = "Forgot Password?"
    
    @EnvironmentObject var userModel: UserStateViewModel
    
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
                        CustomTextField(image: "envelope", title: "USERNAME/EMAIL", value: $emailId,animation: animation)
                            .padding(.top,10)
                        
                        CustomTextField(image: "lock", title: "PASSWORD", value: $password,animation: animation)
                            .padding(.top,5)
                            .padding(.bottom,10)
                        
                        Button(action: {
                            self.loading = true
                            self.showLoadingIndicator = true
                            self.userModel.login(username: self.emailId, password: self.password)
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
                        .disabled((password.count < 8) || (emailId.count < 3))
                        .alert(isPresented: $showAlert, content: {
                            Alert(title: Text("Alert"), message: Text("\(self.alertMessage)"), dismissButton: .default(Text("Ok")))
                        })
                        
                    }.padding()
                    //Show Forgot Password
                    ShowHyperLinkView(displayText: $forgotPassword, show: $show)
                }
            }
            .padding(.horizontal)
            .onReceive(userModel.$user, perform:  { user in
                
                //Hide Loader
                self.showLoadingIndicator = false
                
                // Show alert with the message receive from server if login fails
                guard let isLogin = user.login else { return }
                if !(isLogin){
                    self.showAlert = true
                    self.alertMessage = user.message
                }
            })
            .overlay(
                ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .default())
                .frame(width: 50.0, height: 50.0)
                .foregroundColor(.themeColor)
            )
            
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
                    ForgetPasssword(userModel: ForgetViewModel())
                }
                
            }else {
                Text(displayText)
                    .fontWeight(.heavy)
                    .foregroundColor(.gray)
                
                NavigationLink("SignUp") {
                    Register(registerModel: RegisterViewModel())
                }
            }
        }
    }
}
