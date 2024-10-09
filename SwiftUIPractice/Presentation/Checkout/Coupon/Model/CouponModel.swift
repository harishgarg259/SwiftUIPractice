//
//  CouponModel.swift
//  Yappetizer
//
//  Created by Harish Garg on 2024-10-01.
//

import Foundation

struct CouponItem : Codable {
    let id : Int?
    let code : String?
    let amount : String?
    let status : String?
    let date_created : String?
    let date_created_gmt : String?
    let date_modified : String?
    let date_modified_gmt : String?
    let discount_type : String?
    let description : String?
    let date_expires : String?
    let date_expires_gmt : String?
    let usage_count : Int?
    let individual_use : Bool?
    let product_ids : [String]?
    let excluded_product_ids : [String]?
    let usage_limit : String?
    let usage_limit_per_user : String?
    let limit_usage_to_x_items : String?
    let free_shipping : Bool?
    let product_categories : [String]?
    let excluded_product_categories : [String]?
    let exclude_sale_items : Bool?
    let minimum_amount : String?
    let maximum_amount : String?
//    let email_restrictions : [String]?
//    let used_by : [String]?
//    let meta_data : [Coupon_Meta_data]?
//    let _links : Coupon_Links?
    
    
    
    
    
}

struct Coupon_Meta_data : Codable {
    let id : Int?
    let key : String?
    let value : [String]?
}

struct Coupon_Links : Codable {
    let selfLink : [Coupon_Self]?
    let collection : [Coupon_Collection]?

    enum CodingKeys: String, CodingKey {

        case selfLink = "self"
        case collection = "collection"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        selfLink = try values.decodeIfPresent([Coupon_Self].self, forKey: .selfLink)
        collection = try values.decodeIfPresent([Coupon_Collection].self, forKey: .collection)
    }
}

struct Coupon_Collection : Codable {
    let href : String?
}

struct Coupon_Self : Codable {
    let href : String?
}
