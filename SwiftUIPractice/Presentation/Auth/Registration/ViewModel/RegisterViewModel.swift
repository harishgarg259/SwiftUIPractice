//
//  UserStateViewModel.swift
//  Yappetizer
//
//  Created by Harish Garg on 11/02/24.
//

import Foundation

class RegisterViewModel: ObservableObject {
        
    @Published var user: RegisterData = RegisterData(login: nil, data: nil, message: "")

    func register(first_name: String,last_name: String,username: String,password: String) {
        let parameters = ["first_name":first_name,"last_name":last_name,"name":"\(first_name) \(last_name)","email":username,"password": password,"AUTH_KEY":AppConstants.AUTH_KEY]
        let rest = RestManager<RegisterResponse>()
        rest.makeRequest(request : WebAPI().auth(params : parameters, type: .register)!) { (result) in
            switch result {
            case .success(let response):
                debugPrint(response)
                self.user = RegisterData(login: true, data: response, message: "")
            case .failure(let error):
                debugPrint(error.description)
                self.user = RegisterData(login: false, data: nil, message: error.description)
            }
        }
    }
}
