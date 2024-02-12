//
//  Register.swift
//  Yappetizer
//
//  Created by Harish Garg on 04/02/24.
//

import SwiftUI

struct Register: View {
    
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var name = ""
    
    @Binding var show : Bool
    @State var showHome = false
    
    @Namespace var animation
    
    var body: some View {
        
            ScrollView(.vertical, showsIndicators: false, content: {
                
                VStack{
                    
                    HStack{
                        
                        Text("Create Account")
                            .font(.system(size: 32))
                            .fontWeight(.heavy)
                            .foregroundColor(.primary)
                        
                        Spacer(minLength: 0)
                    }
                    
                    CustomTextField(image: "person", title: "FULL NAME", value: $name, animation: animation)
                    
                    CustomTextField(image: "envelope", title: "EMAIL", value: $email, animation: animation)
                        .padding(.top,5)
                    
                    CustomTextField(image: "lock", title: "PASSWORD", value: $password, animation: animation)
                        .padding(.top,5)
                    
                    CustomTextField(image: "lock", title: "CONFIRM PASSWORD", value: $confirmPassword, animation: animation)
                        .padding(.top,5)
                        .padding(.bottom,20)
                    
                    Button {
                        self.showHome = true
                    } label: {
                        Text("Register")
                            .frame(maxWidth: .infinity)
                            .fontWeight(.bold)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .shadow(color: .themeColor,radius: 2)
                    .disabled(name.count < 3 || password.count < 8 || (confirmPassword != password) || (email.textFieldValidatorEmail() == false))
                    .navigationDestination(isPresented: $showHome) {
                        BaseView()
                    }
                    
                    HStack{
                        
                        Text("Already have a account?")
                            .fontWeight(.heavy)
                            .foregroundColor(.gray)
                        
                        Button(action: {show.toggle()}) {
                            Text("sign in")
                                .fontWeight(.heavy)
                                .foregroundColor(.themeColor)
                        }
                    }
                    .padding()
                    .padding(.top,5)
                    
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
            })
            .padding(.top, 10)
            .tint(.themeColor)
            .scrollDismissesKeyboard(.immediately)
    }
}

#Preview {
    Register(show: .constant(true))
}
