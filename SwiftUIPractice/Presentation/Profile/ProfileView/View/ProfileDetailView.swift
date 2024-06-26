//
//  ProfileView.swift
//  Yappetizer
//
//  Created by Harish Garg on 25/06/24.
//

import SwiftUI
import ActivityIndicatorView

struct ProfileDetailView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @Namespace var animation
    @State var showAlert = false
    @State var alertMessage: String = ""
    @State var showLoadingIndicator = false
    @State private var isSuccess = false
    @StateObject var userModel: ProfileDetailViewViewModel = ProfileDetailViewViewModel()
    @EnvironmentObject var userState: UserStateViewModel

    var body: some View {
        VStack(spacing: 20) {

            CustomTextField(image: "person", title: "FIRST NAME", value: $firstName, animation: animation)
            CustomTextField(image: "person", title: "LAST NAME", value: $lastName, animation: animation)
            
            CustomTextField(image: "envelope", title: "EMAIL", value: $email, animation: animation)
                .padding(.top,5)
            
            Button(action: {
                self.showLoadingIndicator = true
                self.userModel.updateProfile(firstName: firstName,lastName: lastName,email: email)
            }, label: {
                Text("Update Profile")
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
                    }
                }
            }
            .onReceive(userModel.$response, perform:  { response in
                
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
        .onAppear(perform: {
            prefillUserDetail()
        })
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
        return !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty
    }
    
    func prefillUserDetail(){
        firstName = (userState.userDetail()?.first_name ?? "").capitalized
        lastName = (userState.userDetail()?.last_name ?? "").capitalized
        email = (userState.userDetail()?.email ?? "")
    }

}

struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView()
    }
}
