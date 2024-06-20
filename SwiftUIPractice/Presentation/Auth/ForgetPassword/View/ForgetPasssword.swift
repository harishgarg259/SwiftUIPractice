//
//  ForgetPasssword.swift
//  Yappetizer
//
//  Created by Harish Garg on 10/02/24.
//

import SwiftUI
import ActivityIndicatorView

struct ForgetPasssword: View {
    
    @State var email = ""
    @Namespace var animation
    @State var transition: Int? = 0
    @State var showLoadingIndicator = false
    @State private var loading = false
    @State var alertMessage: String = ""
    @State var showAlert = false
    @State private var isSuccess = false
    @Environment(\.dismiss) var dismiss
    
    //@Binding var show : Bool
    @StateObject var userModel: ForgetViewModel
    
    var body: some View {
        
        VStack{
            HStack{
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Forget Password")
                        .font(.system(size: 32, weight: .heavy))
                    // for Dark Mode Adoption...
                        .foregroundColor(.primary)
                    
                    Text("Please enter your registered email")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                }
                Spacer(minLength: 0)
            }
            
            CustomTextField(image: "envelope", title: "EMAIL", value: $email,animation: animation)
                .padding(.top,10)
                .padding(.bottom,20)
            
            Button {
                self.showLoadingIndicator = true
                self.userModel.forgotPassword(email: self.email)
            } label: {
                Text("Send Link")
                    .frame(maxWidth: .infinity)
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .shadow(color: .themeColor,radius: 2)
            .padding(.top, 10)
            .disabled((email.textFieldValidatorEmail() == false))
            .alert("\(self.alertMessage)", isPresented: $showAlert) {
                Button("OK") {
                    if self.isSuccess{
                        dismiss()
                    }
                }
            }
            
            Spacer(minLength: 0)
        }
        .tint(.themeColor)
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .padding(.top, 60)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .onReceive(userModel.$success, perform:  { user in
            
            //Hide Loader
            self.showLoadingIndicator = false
            
            // Show alert with the message receive from server if api fails
            guard let isLogin = user?.1 else { return }
            self.isSuccess = isLogin
            self.showAlert = true
            self.alertMessage = user?.0 ?? "Email does not exist"
        })
        .overlay(
            ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .default())
                .frame(width: 50.0, height: 50.0)
                .foregroundColor(.themeColor)
        )
    }
}

#Preview {
    ForgetPasssword(userModel: ForgetViewModel())
}
