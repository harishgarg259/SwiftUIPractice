//
//  AddressDetailViewModel.swift
//  Yappetizer
//
//  Created by Harish Garg on 19/06/24.
//

import Foundation

class AddressDetailViewModel: ObservableObject {
    var states: [States] = []
    
    
    
    
    func updateProfile() {
        
        let specialPUTParams = "\(UserDefaultsManager.userID ?? 0)"
        let params = ["consumer_key":AppConstants.Consumer_Key, "consumer_secret": AppConstants.Consumer_Secret]

        let rest = RestManager<CustomerProfile>()
        rest.makeRequest(request : WebAPI().auth(params : params, type: .updateAddress,specialPUTParams: specialPUTParams)!) { (result) in
            switch result {
            case .success(let response):
                debugPrint(response)
                UserDefaultsManager.userID = response.id
                self.saveLocalCache(response: response)
            case .failure(let error):
                debugPrint(error.description)
            }
        }
    }
    
    func saveLocalCache(response: CustomerProfile) {
        let userID = "\(UserDefaultsManager.userID ?? 0)"
        let storage = PawStorageManager.PawStorageFile.customerDetail(userID)
        PawStorageManager.shared.store(response, to: .caches, as: storage)
    }
}
