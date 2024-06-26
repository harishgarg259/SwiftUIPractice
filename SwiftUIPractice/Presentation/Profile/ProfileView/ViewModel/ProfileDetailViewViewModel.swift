//
//  ProfileDetailViewViewModel.swift
//  Yappetizer
//
//  Created by Harish Garg on 25/06/24.
//

import Foundation

@MainActor
class ProfileDetailViewViewModel: ObservableObject {
    
    @Published var response: (String?, Bool)?
    
    func updateProfile(firstName: String,lastName: String,email: String) {
        
        let parameters = ["first_name": firstName, "last_name":lastName, "email": email]
        
        let specialPUTParams = "\(UserDefaultsManager.userID ?? 0)"
        
        let rest = RestManager<UserProfile>()
        rest.makeRequest(request : WebAPI().auth(params : parameters, type: .updateProfile, specialPUTParams: specialPUTParams)!) { (result) in
            switch result {
            case .success(let response):
                debugPrint(response)
                self.response = ("Profile updated successfully",true)
                self.saveLocalCache(response: response)
            case .failure(let error):
                self.response = (error.description,false)
                debugPrint(error.description)
            }
        }
    }
    
    func saveLocalCache(response: UserProfile) {
        let userID = "\(UserDefaultsManager.userID ?? 0)"
        let storage = PawStorageManager.PawStorageFile.userDetail(userID)
        PawStorageManager.shared.store(response, to: .caches, as: storage)
    }
}
