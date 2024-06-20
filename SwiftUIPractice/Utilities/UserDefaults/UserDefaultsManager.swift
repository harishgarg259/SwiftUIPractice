//
//  UserDefaultsManager.swift
//  Yappetizer
//
//  Created by Harish Garg on 18/06/24.
//

import Foundation
class UserDefaultsManager {
    
    static var authToken: String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: UserDefaultConstants.authToken.value)
        } get {
            return UserDefaults.standard.value(forKey: UserDefaultConstants.authToken.value) as? String
        }
    }
    
    static var userID: Int? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: UserDefaultConstants.userId.value)
        } get {
            return UserDefaults.standard.value(forKey: UserDefaultConstants.userId.value) as? Int
        }
    }
    
    static var isLoggedIn: Bool? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: UserDefaultConstants.isLoggedIn.value)
        } get {
            return UserDefaults.standard.value(forKey: UserDefaultConstants.isLoggedIn.value) as? Bool
        }
    }
}

extension UserDefaultsManager {
    
    static func save(value: Any, forKey key: UserDefaultConstants) {
        UserDefaults.standard.set(value, forKey: key.value)
        UserDefaults.standard.synchronize()
    }
    
    static func removeValue(forKey key: UserDefaultConstants) {
        UserDefaults.standard.removeObject(forKey: key.value)
        UserDefaults.standard.synchronize()
    }
}
