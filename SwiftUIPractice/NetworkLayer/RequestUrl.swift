//
//  RequestUrl.swift
//  Workday
//
//  Created by Harish Garg on 26/08/23.
//

import Foundation

enum RequestUrl :String{
    
    //App Base URL
    static var AuthTokenURL = "https://www.pawsitivelycanadian.ca/wp-json/jwt-auth/v1"
    static var UserBaseURL = "https://www.pawsitivelycanadian.ca/?rest_route=/simple-jwt-login/v1"
    static var WPBaseURL = "https://www.pawsitivelycanadian.ca/wp-json/wp/v2"
    static var WooBaseURL = "https://www.pawsitivelycanadian.ca/wp-json/wc/v2"
    static var WooOrderBaseURL = "https://www.pawsitivelycanadian.ca/wp-json/wc/v3"
    static var MenuBaseURL = "https://www.pawsitivelycanadian.ca/wp-json/wp-api-menus/v2"

    //Complete API url
    var tokenURL : String{ return RequestUrl.AuthTokenURL + self.rawValue }
    var userURL : String{ return RequestUrl.UserBaseURL + self.rawValue }
    var profile : String{ return RequestUrl.WPBaseURL + self.rawValue }
    var products : String{ return RequestUrl.WooBaseURL + self.rawValue }
    var menu : String{ return RequestUrl.MenuBaseURL + self.rawValue }

    
    
    //Nasa Apis
    case token = "/token"
    case user = "/users"
    case resetPassword = "/user/reset_password"
    case getProfile = "/users/me"
    case customerProfile = "/customers/"
    
    //Products
    case products = "/products"
    
    //Menus
    case menus = "/menus"
    case subMenus = "/menus/2"

    //Orders
    case orders = "/orders"
    case coupons = "/coupons"
    
    //Payments
    case gatewayList = "/payment_gateways"
    
    //About App
    case blog = "/posts"
    case aboutApp = "/pages"
    
}
