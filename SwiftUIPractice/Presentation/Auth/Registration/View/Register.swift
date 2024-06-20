//
//  Register.swift
//  Yappetizer
//
//  Created by Harish Garg on 04/02/24.
//

import SwiftUI
import ActivityIndicatorView

struct Register: View {
    
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var firstName = ""
    @State var lastName = ""
    @State var showAlert = false
    @State var showLoadingIndicator = false
    @State private var isRegistered = false
    @State var alertMessage: String = ""
    
    //@Binding var show : Bool
    @State var showHome = false
    @StateObject var registerModel: RegisterViewModel
    @Namespace var animation
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            
            VStack{
                
                HStack{
                    
                    Text("Create Account")
                        .font(.system(size: 32))
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                    
                    Spacer(minLength: 0)
                }
                
                CustomTextField(image: "person", title: "FIRST NAME", value: $firstName, animation: animation)
                CustomTextField(image: "person", title: "LAST NAME", value: $lastName, animation: animation)
                
                CustomTextField(image: "envelope", title: "EMAIL", value: $email, animation: animation)
                    .padding(.top,5)
                
                CustomTextField(image: "lock", title: "PASSWORD", value: $password, animation: animation)
                    .padding(.top,5)
                
                CustomTextField(image: "lock", title: "CONFIRM PASSWORD", value: $confirmPassword, animation: animation)
                    .padding(.top,5)
                    .padding(.bottom,20)
                
                Button {
                    self.showLoadingIndicator = true
                    self.registerModel.register(first_name: firstName, last_name: lastName, username: email, password: password)
                } label: {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .shadow(color: .themeColor,radius: 2)
                .disabled(firstName.count < 3 || lastName.count < 3 || password.count < 8 || (confirmPassword != password) || (email.textFieldValidatorEmail() == false))
                .alert("\(self.alertMessage)", isPresented: $showAlert) {
                    Button("OK") {
                        if self.isRegistered{
                            dismiss()
                        }
                    }
                }
                .navigationDestination(isPresented: $showHome) {
                    BaseView()
                }
                
                showLoginScreen()
                
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
        }
        .padding(.top, 10)
        .onReceive(registerModel.$user, perform:  { user in
            
            //Hide Loader
            self.showLoadingIndicator = false
            
            // Show alert with the message receive from server if login fails
            guard let isLogin = user.login else { return }
            if !(isLogin){
                self.alertMessage = user.message
                self.isRegistered = false
            }else{
                self.alertMessage = "User has been registered successfully. Please login."
                self.isRegistered = true
            }
            self.showAlert = true
        })
        .overlay(
            ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .default())
                .frame(width: 50.0, height: 50.0)
                .foregroundColor(.themeColor)
        )
        .tint(.themeColor)
        .scrollDismissesKeyboard(.immediately)
    }
}

#Preview {
    Register(registerModel: RegisterViewModel())
}

struct showLoginScreen: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack{
            Text("Already have a account?")
                .fontWeight(.heavy)
                .foregroundColor(.gray)
            
            Button(action: {
                dismiss()
            }, label: {
                Text("LogIn")
                    .fontWeight(.heavy)
                    .foregroundColor(.themeColor)
            })
        }
        .padding()
        .padding(.top,5)
    }
}
