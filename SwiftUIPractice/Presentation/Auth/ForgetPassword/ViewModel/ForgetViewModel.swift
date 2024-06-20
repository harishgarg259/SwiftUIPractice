//
//  ForgetViewModel.swift
//  Yappetizer
//
//  Created by Harish Garg on 11/02/24.
//

import Foundation

class ForgetViewModel: ObservableObject {
        
    @Published var success: (String,Bool)?

    func forgotPassword(email: String) {
        let parameters = ["email":email,"AUTH_KEY":AppConstants.AUTH_KEY]
        let rest = RestManager<RegisterResponse>()
        rest.makeRequest(request : WebAPI().auth(params : parameters, type: .forgotPassword)!) { (result) in
            switch result {
            case .success(let response):
                debugPrint(response)
                self.success = (response.message ?? "Reset password email has been sent.",true)
            case .failure(let error):
                debugPrint(error.description)
                self.success = (error.description,false)
            }
        }
    }
}
