//
//  LoginModel.swift
//  Yappetizer
//
//  Created by Harish Garg on 28/05/24.
//

import Foundation

struct RegisterResponse : Codable {
    var success : Bool?
    var id : String?
    var message : String?
    var user : User?
    var roles : [String]?
}

struct User : Codable {
    var iD : String?
    var user_login : String?
    var user_nicename : String?
    var user_email : String?
    var user_url : String?
    var user_registered : String?
    var user_activation_user_activation_key : String?
    var user_status : String?
    var display_name : String?
    var user_level : Int?
}

struct RegisterData: Codable {
    var login: Bool?
    var data: RegisterResponse?
    var message: String
}


struct RegisterErrorResponse : Codable {
    let success : Bool?
    let data : RegisterError?
}

struct RegisterError : Codable {
    let message : String?
    let errorCode : Int?
}
