//
//  PaymentMethod.swift
//  Yappetizer
//
//  Created by Harish Garg on 26/06/24.
//

import SwiftUI
import ActivityIndicatorView

struct PaymentMethod: View {
    @State private var oldPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @Namespace var animation
    @State var showAlert = false
    @State var alertMessage: String = ""
    @StateObject var viewModel: PaymentMethodViewModel = PaymentMethodViewModel()
    @State var showLoadingIndicator = false
    @State private var isSuccess = false
    @EnvironmentObject var userState: UserStateViewModel

    var body: some View {
        VStack(spacing: 20) {

            CustomTextField(image: "lock", title: "OLD PASSWORD", value: $oldPassword,animation: animation)
                .padding(.top,5)
                .padding(.bottom,10)
            
            CustomTextField(image: "lock", title: "NEW PASSWORD", value: $newPassword,animation: animation)
                .padding(.top,5)
                .padding(.bottom,10)
            
            CustomTextField(image: "lock", title: "CONFIRM PASSWORD", value: $confirmPassword,animation: animation)
                .padding(.top,5)
                .padding(.bottom,10)
            
            Button(action: {
                self.showLoadingIndicator = true
                self.viewModel.paymentMethod(oldPassword: self.oldPassword, newPassword: self.newPassword)
            }, label: {
                Text("Update Password")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .cornerRadius(10)
            })
            .padding(.top,30)
            .buttonStyle(.borderedProminent)
            .shadow(color: .themeColor,radius: 2)
            .disabled(!isUpdateButtonEnabled)
            .alert("\(self.alertMessage)", isPresented: $showAlert) {
                Button("OK") {
                    if self.isSuccess{
                        moveToLogin()
                    }
                }
            }
            .onReceive(viewModel.$response, perform:  { response in
                
                //Hide Loader
                self.showLoadingIndicator = false
                
                // Show alert with the message receive from server if login fails
                guard let isSucceed = response?.1 else { return }
                self.isSuccess = isSucceed
                self.showAlert = true
                self.alertMessage = response?.0 ?? ""
            })
            
            Spacer()
        }
        .overlay(
            ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .default())
            .frame(width: 50.0, height: 50.0)
            .foregroundColor(.themeColor)
        )
        .padding()
        .navigationBarTitle("Update Password",displayMode: .inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .tint(.themeColor)
    }

    var isUpdateButtonEnabled: Bool {
        return !newPassword.isEmpty && newPassword.count >= 8 && newPassword == confirmPassword
    }
    
    func moveToLogin(){
        UserDefaultsManager.isLoggedIn = false
        userState.isLoggedIn = false
    }
}

struct PaymentMethod_Previews: PreviewProvider {
    static var previews: some View {
        PaymentMethod()
    }
}
