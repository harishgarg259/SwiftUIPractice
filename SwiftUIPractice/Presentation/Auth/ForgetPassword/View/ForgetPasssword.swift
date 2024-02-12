//
//  ForgetPasssword.swift
//  Yappetizer
//
//  Created by Harish Garg on 10/02/24.
//

import SwiftUI

struct ForgetPasssword: View {
    
    @State var email = ""
    @Namespace var animation
    @State var transition: Int? = 0
    
    @Binding var show : Bool

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

                Spacer(minLength: 0)
            }
            .tint(.themeColor)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.top, 60)
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
    }
}

#Preview {
    ForgetPasssword(show: .constant(false))
}
