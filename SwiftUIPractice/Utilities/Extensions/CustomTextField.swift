//
//  CustomTextField.swift
//  Login SignUp App
//
//  Created by Marwan on 19/08/2021.
//

import SwiftUI

struct CustomTextField: View {
    
    // Fields...
    var image: String
    var title: String
    @Binding var value: String
    
    var animation: Namespace.ID
    
    var body: some View {
        
        VStack(spacing: 6){
            
            HStack(alignment: .bottom){
                
                Image(systemName: image)
                    .font(.system(size: 22))
                    .foregroundColor(value == "" ? .gray : .primary)
                    .frame(width: 35)
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    if value != ""{
                        
                        Text(title)
                            .font(.caption)
                            .fontWeight(.heavy)
                            .foregroundColor(.gray)
                            .matchedGeometryEffect(id: title, in: animation)
                    }
                    
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                        
                        if value == ""{
                            
                            Text(title)
                                .font(.caption)
                                .fontWeight(.heavy)
                                .foregroundColor(.gray)
                                .matchedGeometryEffect(id: title, in: animation)
                        }
                        
                        if title.contains("PASSWORD"){
                            
                            SecureField("", text: $value)
                        }
                        else{
                            TextField("", text: $value)
                            // For Phone Number...
                                .keyboardType(title == "PHONE NUMBER" ? .numberPad : .default)
                                .autocapitalization(.none)
                                .submitLabel(.done)
                        }
                    }
                }
            }
            
            if value == ""{
                Divider()
            }
        }
        .background(Color("txt").opacity(value != "" ? 1 : 0))
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(value == "" ? 0 : 0.1), radius: 5, x: 5, y: 5)
        .shadow(color: Color.black.opacity(value == "" ? 0 : 0.05), radius: 5, x: -5, y: -5)
        .padding(.top)
    }
}


extension String{
    func textFieldValidatorEmail() -> Bool {
        var isValidEmail: Bool {
                NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
        }
        return isValidEmail
    }
}
