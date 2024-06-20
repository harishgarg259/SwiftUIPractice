//
//  LoginModel.swift
//  Yappetizer
//
//  Created by Harish Garg on 28/05/24.
//

import Foundation


struct UserToken: Codable {
    var token: String?
    var user_display_name: String?
    var user_email: String?
    var user_nicename: String?
}

struct UserApiData: Codable {
    var login: Bool?
    var data: UserToken?
    var message: String
    var token: String?
}

struct UserProfile : Codable {
    let id : Int?
    let username : String?
    let name : String?
    let first_name : String?
    let last_name : String?
    let email : String?
    let url : String?
    let description : String?
    let link : String?
    let locale : String?
    let nickname : String?
    let slug : String?
    let roles : [String]?
    let registered_date : String?
    let capabilities : Capabilities?
    let extra_capabilities : Extra_capabilities?
    let avatar_urls : Avatar_urls?
    let meta : Meta?
    let yoast_head : String?
    let yoast_head_json : String?
    let is_super_admin : Bool?
    let woocommerce_meta : Woocommerce_meta?
    let _links : _links?
}

struct Capabilities : Codable {
    let read : Bool?
    let level_0 : Bool?
    let subscriber : Bool?
}

struct Extra_capabilities : Codable {
    let subscriber : Bool?
}

struct Avatar_urls : Codable {
    let _24 : String?
    let _48 : String?
    let _96 : String?
}

struct Meta : Codable {
    let persisted_preferences : [String]?
}

struct Woocommerce_meta : Codable {
    let variable_product_tour_shown : String?
    let activity_panel_inbox_last_read : String?
    let activity_panel_reviews_last_read : String?
    let categories_report_columns : String?
    let coupons_report_columns : String?
    let customers_report_columns : String?
    let orders_report_columns : String?
    let products_report_columns : String?
    let revenue_report_columns : String?
    let taxes_report_columns : String?
    let variations_report_columns : String?
    let dashboard_sections : String?
    let dashboard_chart_type : String?
    let dashboard_chart_interval : String?
    let dashboard_leaderboard_rows : String?
    let homepage_layout : String?
    let homepage_stats : String?
    let task_list_tracked_started_tasks : String?
    let help_panel_highlight_shown : String?
    let android_app_banner_dismissed : String?
}

struct _links : Codable {
    let _self : [Self]?
    let collection : [Collection]?
}

struct Collection : Codable {
    let href : String?
}
