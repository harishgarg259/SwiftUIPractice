//
//  UserStateViewModel.swift
//  Yappetizer
//
//  Created by Harish Garg on 11/02/24.
//

import Foundation

@MainActor
class UserStateViewModel: ObservableObject {
    
    @Published var isLoggedIn = false
    @Published var user: UserApiData = UserApiData(login: nil, data: nil, message: "", token: "")
    
    func login(username: String,password: String) {
        let parameters = ["username":username,"password": password]
        let rest = RestManager<UserToken>()
        rest.makeRequest(request : WebAPI().auth(params : parameters, type: .token)!) { (result) in
            switch result {
            case .success(let response):
                debugPrint(response)
                UserDefaultsManager.authToken = response.token
                UserDefaultsManager.isLoggedIn = true
                self.user = UserApiData(login: true, data: response, message: "", token: response.token)
                self.getProfile()
            case .failure(let error):
                self.isLoggedIn = false
                debugPrint(error.description)
                self.user = UserApiData(login: false, data: nil, message: error.description, token: "")
            }
        }
    }
    
    func getProfile() {
        let rest = RestManager<UserProfile>()
        rest.makeRequest(request : WebAPI().auth(params : [:], type: .getProfile)!) { (result) in
            switch result {
            case .success(let response):
                debugPrint(response)
                self.isLoggedIn = true
                UserDefaultsManager.userID = response.id
                self.saveLocalCache(response: response)
            case .failure(let error):
                debugPrint(error.description)
            }
        }
    }
    
    func saveLocalCache(response: UserProfile) {
        let userID = "\(UserDefaultsManager.userID ?? 0)"
        let storage = PawStorageManager.PawStorageFile.userDetail(userID)
        PawStorageManager.shared.store(response, to: .caches, as: storage)
    }
    
    func userDetail() -> UserProfile? {
        let userID = "\(UserDefaultsManager.userID ?? 0)"
        let storage = PawStorageManager.PawStorageFile.userDetail(userID)
        let response = PawStorageManager.shared.retrieve(storage, from: .caches, as: UserProfile.self)
        return response
    }
    
    func customerProfile() -> CustomerProfile? {
        let userID = "\(UserDefaultsManager.userID ?? 0)"
        let storage = PawStorageManager.PawStorageFile.customerDetail(userID)
        let response = PawStorageManager.shared.retrieve(storage, from: .caches, as: CustomerProfile.self)
        return response
    }
}
