//
//  ForgetPasswordResponse.swift
//  Yappetizer
//
//  Created by Harish Garg on 28/05/24.
//

import Foundation

struct ForgetPasswordResponse : Codable {
    var success : Bool?
    var id : String?
    var message : String?
    var user : User?
    var roles : [String]?
}
