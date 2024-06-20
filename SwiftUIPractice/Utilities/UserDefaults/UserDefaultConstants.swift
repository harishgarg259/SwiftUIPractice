//
//  UserDefaultConstants.swift
//  BallerDesign
//
//  Created by user on 19/08/22.
//

import Foundation

enum UserDefaultConstants {
    case userId
    case isLoggedIn
    case authToken

    var value: String {
        switch self {
        case .userId: return "userId"
        case .isLoggedIn: return "isLoggedIn"
        case .authToken: return "authToken"
        }
    }
}
