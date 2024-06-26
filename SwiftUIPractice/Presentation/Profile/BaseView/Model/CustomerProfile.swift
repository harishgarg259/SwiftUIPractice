//
//  CustomerProfile.swift
//  Yappetizer
//
//  Created by Harish Garg on 18/06/24.
//

import Foundation

struct CustomerProfile : Codable {
    let id : Int?
    let date_created : String?
    let date_created_gmt : String?
    let date_modified : String?
    let date_modified_gmt : String?
    let email : String?
    let first_name : String?
    let last_name : String?
    let role : String?
    let username : String?
    let billing : AddressDetail?
    let shipping : AddressDetail?
    let is_paying_customer : Bool?
    let avatar_url : String?
    let meta_data : [Meta_data]?
    let orders_count : Int?
    let total_spent : String?
    let _links : Links?
}

struct AddressDetail : Codable {
    let first_name : String?
    let last_name : String?
    let company : String?
    let address_1 : String?
    let address_2 : String?
    let city : String?
    let postcode : String?
    let country : String?
    let state : String?
    let email : String?
    let phone : String?
}

struct Shipping : Codable {
    let first_name : String?
    let last_name : String?
    let company : String?
    let address_1 : String?
    let address_2 : String?
    let city : String?
    let postcode : String?
    let country : String?
    let state : String?
    let phone : String?
    let email : String?
}
