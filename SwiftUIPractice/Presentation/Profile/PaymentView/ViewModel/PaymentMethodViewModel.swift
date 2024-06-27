//
//  PaymentMethodViewModel.swift
//  Yappetizer
//
//  Created by Harish Garg on 26/06/24.
//

import Foundation

@MainActor
class PaymentMethodViewModel: ObservableObject {
    
    @Published var response: (String?, Bool)?
    
    func paymentMethod(oldPassword: String,newPassword: String) {
        let parameters = ["user_id": "\(UserDefaultsManager.userID ?? 0)", "password":oldPassword,"new_password": newPassword]
        let rest = RestManager<UpdatePassword>()
        rest.makeRequest(request : WebAPI().auth(params : parameters, type: .updatePassword)!) { (result) in
            switch result {
            case .success(let response):
                debugPrint(response)
                self.response = (response.msg,true)
            case .failure(let error):
                self.response = (error.description,false)
                debugPrint(error.description)
            }
        }
    }
}
