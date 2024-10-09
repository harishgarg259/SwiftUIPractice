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
    
    func formattedAddress() -> String {
        
        var formattedAddress = String()
        
        if let address1 = address_1, !address1.isEmpty
        {
            formattedAddress.append(address1)
        }
        if let address2 = address_2, !address2.isEmpty
        {
            formattedAddress.append(", \(address2)")
        }
        if let city = city, let postcode = postcode, !city.isEmpty
        {
            formattedAddress.append(", \(city), \(postcode)")
        }
        if let state = state, !state.isEmpty
        {
            formattedAddress.append(", \(state)")
        }
        if let country = country, !country.isEmpty
        {
            formattedAddress.append(", \(country)")
        }
        return formattedAddress
    }
    
    func customerDetail() -> String {
        
        var formattedAddress = String()
        
        if let first_name = first_name, !first_name.isEmpty
        {
            formattedAddress.append(first_name)
        }
        if let last_name = last_name, !last_name.isEmpty
        {
            formattedAddress.append(" \(last_name)")
        }
        if let postcode = postcode, !postcode.isEmpty
        {
            formattedAddress.append(", \(postcode)")
        }
        return formattedAddress
    }
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
    
    func formattedAddress() -> String {
        
        var formattedAddress = String()
        
        if let address1 = address_1, !address1.isEmpty
        {
            formattedAddress.append(address1)
        }
        if let address2 = address_2, !address2.isEmpty
        {
            formattedAddress.append(", \(address2)")
        }
        if let city = city, let postcode = postcode, !city.isEmpty
        {
            formattedAddress.append(", \(city), \(postcode)")
        }
        if let state = state, !state.isEmpty
        {
            formattedAddress.append(", \(state)")
        }
        if let country = country, !country.isEmpty
        {
            formattedAddress.append(", \(country)")
        }
        return formattedAddress
    }
    
    func customerDetail() -> String {
        
        var formattedAddress = String()
        
        if let first_name = first_name, !first_name.isEmpty
        {
            formattedAddress.append(first_name)
        }
        if let last_name = last_name, !last_name.isEmpty
        {
            formattedAddress.append(" \(last_name)")
        }
        if let postcode = postcode, !postcode.isEmpty
        {
            formattedAddress.append(", \(postcode)")
        }
        return formattedAddress
    }
}


