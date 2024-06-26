//
//  AddressDetailViewModel.swift
//  Yappetizer
//
//  Created by Harish Garg on 19/06/24.
//

import Foundation
import SwiftUI

class AddressDetailViewModel: ObservableObject {
    
    enum State {
        case idle
        case loading
        case success
        case failed(message: String)
    }
    
    var states: [States] = []
    @Published var isLoggedIn = false
    @Published private(set) var state: State = .idle
    
    func updateProfile(firstName: String, lastName: String, email: String, companyName: String,streetAddress: String,apartmentName: String,town: String,postcode: String,countryText: String,stateText: String,phone: String,type: String) {
        
        var address =  [
            "first_name": firstName,
            "last_name": lastName,
            "company": companyName,
            "address_1": streetAddress,
            "address_2": apartmentName,
            "city": town,
            "postcode": postcode,
            "country": countryText,
            "state": stateText,
            "phone": phone,
            "email": email
        ]
        
        let params = [type == "Billing Address" ? "billing" : "shipping":address] as [String : Any]
        let specialPUTParams = "\(UserDefaultsManager.userID ?? 0)?consumer_key=\(AppConstants.Consumer_Key)&consumer_secret=\(AppConstants.Consumer_Secret)"
        
        let rest = RestManager<CustomerProfile>()
        rest.makeRequest(request : WebAPI().auth(params : params, type: .updateAddress,specialPUTParams: specialPUTParams)!) { (result) in
            switch result {
            case .success(let response):
                debugPrint(response)
                self.state = .success
                UserDefaultsManager.userID = response.id
                self.saveLocalCache(response: response)
            case .failure(let error):
                debugPrint(error.description)
                self.state = .failed(message: error.description)
            }
        }
    }
    
    func saveLocalCache(response: CustomerProfile) {
        let userID = "\(UserDefaultsManager.userID ?? 0)"
        let storage = PawStorageManager.PawStorageFile.customerDetail(userID)
        PawStorageManager.shared.store(response, to: .caches, as: storage)
    }
}
