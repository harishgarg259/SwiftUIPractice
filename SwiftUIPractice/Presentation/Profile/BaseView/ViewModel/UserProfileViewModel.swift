//
//  UserProfileViewModel.swift
//  Yappetizer
//
//  Created by Harish Garg on 18/06/24.
//

import Foundation

@MainActor
class UserProfileViewModel: ObservableObject {
    
    @Published var userDetail: CustomerProfile?
    
    init() {
        getProfile()
    }
    
    func getProfile() {
        
        let specialGETParams = "\(UserDefaultsManager.userID ?? 0)?consumer_key=\(AppConstants.Consumer_Key)&consumer_secret=\(AppConstants.Consumer_Secret)&\(String.random())"
        let rest = RestManager<CustomerProfile>()
        rest.makeRequest(request : WebAPI().auth(params : [:], type: .customerProfile,specialGETParams: specialGETParams)!) { (result) in
            switch result {
            case .success(let response):
                debugPrint(response)
                self.userDetail = response
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
