//
//  AppConstant.swift
//  Workday
//
//  Created by Harish Garg on 27/08/23.
//

import Foundation

struct AppConstants {
    
    static let limitPerPage: Int = 20
    static let searchCharacterLimit: Int = 1

    static let blogURL: String = "https://www.pawsitivelycanadian.ca/blog-new/"
    static let aboutUsURL: String = "https://www.pawsitivelycanadian.ca/about-us/"
    static let contactUsURL: String = "https://www.pawsitivelycanadian.ca/contact-us/"
    static let AUTH_KEY = "ck_e339a1139183dd95a226e7bbe575acda2f966c91"
    static let Consumer_Key = "ck_83def4695403633dfe7fc2035578d95b1b4247ed"
    static let Consumer_Secret = "cs_458ac2d2ac1444680d1ffabaeb5f0e2f7a66a77a"

    static let STRIPE_PUBLISHING_KEY = "pk_test_51BTUDGJAJfZb9HEBwDg86TN1KNHjkfipXmEDMb0grSCassK5T3ZfxsAbcgKVmAIXF7oZ6ItlZZbXO6idTHE67IM007EwQ4uN3"
    
    
    
    static let ProductListFields = "id,name,regular_price,stock_quantity,date_created, featured,description,price,sale_price,price_html,on_sale,in_stock,weight,images,price,attributes,categories"

    
}
