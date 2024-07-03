//
//  ProductListModel.swift
//  Yappetizer
//
//  Created by Harish Garg on 11/06/24.
//

import Foundation

struct ProductListModel : Codable {
    let id : Int?
    let name : String?
    let regular_price : String?
    let stock_quantity : Int?
    let date_created : String?
    let featured : Bool?
    let description : String?
    let price : String?
    let sale_price : String?
    let on_sale : Bool?
    let in_stock : Bool?
    let weight : String?
    let images : [ProductImages]?
    let attributes : [Attributes]?
    let categories : [Categories]?
    let price_html : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case regular_price = "regular_price"
        case stock_quantity = "stock_quantity"
        case date_created = "date_created"
        case featured = "featured"
        case description = "description"
        case price = "price"
        case sale_price = "sale_price"
        case on_sale = "on_sale"
        case in_stock = "in_stock"
        case weight = "weight"
        case images = "images"
        case attributes = "attributes"
        case categories = "categories"
        case price_html = "price_html"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        regular_price = try values.decodeIfPresent(String.self, forKey: .regular_price)
        stock_quantity = try values.decodeIfPresent(Int.self, forKey: .stock_quantity)
        date_created = try values.decodeIfPresent(String.self, forKey: .date_created)
        featured = try values.decodeIfPresent(Bool.self, forKey: .featured)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        sale_price = try values.decodeIfPresent(String.self, forKey: .sale_price)
        on_sale = try values.decodeIfPresent(Bool.self, forKey: .on_sale)
        in_stock = try values.decodeIfPresent(Bool.self, forKey: .in_stock)
        weight = try values.decodeIfPresent(String.self, forKey: .weight)
        images = try values.decodeIfPresent([ProductImages].self, forKey: .images)
        attributes = try values.decodeIfPresent([Attributes].self, forKey: .attributes)
        categories = try values.decodeIfPresent([Categories].self, forKey: .categories)
        price_html = try values.decodeIfPresent(String.self, forKey: .price_html)
    }

}


//struct ProductListModel : Codable {
//    let id : Int?
//    let name : String?
//    let slug : String?
//    let permalink : String?
//    let date_created : String?
//    let date_created_gmt : String?
//    let date_modified : String?
//    let date_modified_gmt : String?
//    let type : String?
//    let status : String?
//    let featured : Bool?
//    let catalog_visibility : String?
//    let description : String?
//    let short_description : String?
//    let sku : String?
//    let price : String?
//    let regular_price : String?
//    let sale_price : String?
//    let date_on_sale_from : String?
//    let date_on_sale_from_gmt : String?
//    let date_on_sale_to : String?
//    let date_on_sale_to_gmt : String?
//    let on_sale : Bool?
//    let purchasable : Bool?
//    let total_sales : Int?
//    let virtual : Bool?
//    let downloadable : Bool?
//    let downloads : [String]?
//    let download_limit : Int?
//    let download_expiry : Int?
//    let external_url : String?
//    let button_text : String?
//    let tax_status : String?
//    let tax_class : String?
//    let manage_stock : Bool?
//    let stock_quantity : Int?
//    let in_stock : Bool?
//    let backorders : String?
//    let backorders_allowed : Bool?
//    let backordered : Bool?
//    let sold_individually : Bool?
//    let weight : String?
//    let dimensions : Dimensions?
//    let shipping_required : Bool?
//    let shipping_taxable : Bool?
//    let shipping_class : String?
//    let shipping_class_id : Int?
//    let reviews_allowed : Bool?
//    let average_rating : String?
//    let rating_count : Int?
//    let upsell_ids : [Int]?
//    let cross_sell_ids : [Int]?
//    let parent_id : Int?
//    let purchase_note : String?
//    let categories : [Categories]?
//    let tags : [Categories]?
//    let images : [ProductImages]?
//    let attributes : [Attributes]?
//    let default_attributes : [DefaultAttributes]?
//    let variations : [Int]?
//    let grouped_products : [String]?
//    let menu_order : Int?
//    let low_stock_amount : IDQuantumValue?
//    let price_html : String?
//    let related_ids : [Int]?
//    let meta_data : [Meta_data]?
//    let purchase_price : String?
//    let supplier_id : String?
//    let supplier_sku : String?
//    let barcode : String?
//    let atum_controlled : Bool?
//    let out_stock_date : String?
//    let out_stock_threshold : String?
//    let inheritable : Bool?
//    let inbound_stock : Int?
//    let stock_on_hold : Int?
//    let sold_today : Int?
//    let sales_last_days : Int?
//    let reserved_stock : Int?
//    let customer_returns : Int?
//    let warehouse_damage : Int?
//    let lost_in_post : Int?
//    let other_logs : Int?
//    let out_stock_days : Int?
//    let lost_sales : Int?
//    let has_location : Bool?
//    let update_date : String?
//    let atum_locations : [String]?
//    let atum_stock_status : String?
//    let restock_status : Bool?
//    let sales_update_date : String?
//    let calc_backorders : String?
//    let yoast_head : String?
//    let yoast_head_json : YoastHeadJson?
//    let _links : Links?
//    
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case name = "name"
//        case slug = "slug"
//        case permalink = "permalink"
//        case date_created = "date_created"
//        case date_created_gmt = "date_created_gmt"
//        case date_modified = "date_modified"
//        case date_modified_gmt = "date_modified_gmt"
//        case type = "type"
//        case status = "status"
//        case featured = "featured"
//        case catalog_visibility = "catalog_visibility"
//        case description = "description"
//        case short_description = "short_description"
//        case sku = "sku"
//        case price = "price"
//        case regular_price = "regular_price"
//        case sale_price = "sale_price"
//        case date_on_sale_from = "date_on_sale_from"
//        case date_on_sale_from_gmt = "date_on_sale_from_gmt"
//        case date_on_sale_to = "date_on_sale_to"
//        case date_on_sale_to_gmt = "date_on_sale_to_gmt"
//        case on_sale = "on_sale"
//        case purchasable = "purchasable"
//        case total_sales = "total_sales"
//        case virtual = "virtual"
//        case downloadable = "downloadable"
//        case downloads = "downloads"
//        case download_limit = "download_limit"
//        case download_expiry = "download_expiry"
//        case external_url = "external_url"
//        case button_text = "button_text"
//        case tax_status = "tax_status"
//        case tax_class = "tax_class"
//        case manage_stock = "manage_stock"
//        case stock_quantity = "stock_quantity"
//        case in_stock = "in_stock"
//        case backorders = "backorders"
//        case backorders_allowed = "backorders_allowed"
//        case backordered = "backordered"
//        case sold_individually = "sold_individually"
//        case weight = "weight"
//        case dimensions = "dimensions"
//        case shipping_required = "shipping_required"
//        case shipping_taxable = "shipping_taxable"
//        case shipping_class = "shipping_class"
//        case shipping_class_id = "shipping_class_id"
//        case reviews_allowed = "reviews_allowed"
//        case average_rating = "average_rating"
//        case rating_count = "rating_count"
//        case upsell_ids = "upsell_ids"
//        case cross_sell_ids = "cross_sell_ids"
//        case parent_id = "parent_id"
//        case purchase_note = "purchase_note"
//        case categories = "categories"
//        case tags = "tags"
//        case images = "images"
//        case attributes = "attributes"
//        case default_attributes = "default_attributes"
//        case variations = "variations"
//        case grouped_products = "grouped_products"
//        case menu_order = "menu_order"
//        case low_stock_amount = "low_stock_amount"
//        case price_html = "price_html"
//        case related_ids = "related_ids"
//        case meta_data = "meta_data"
//        case purchase_price = "purchase_price"
//        case supplier_id = "supplier_id"
//        case supplier_sku = "supplier_sku"
//        case barcode = "barcode"
//        case atum_controlled = "atum_controlled"
//        case out_stock_date = "out_stock_date"
//        case out_stock_threshold = "out_stock_threshold"
//        case inheritable = "inheritable"
//        case inbound_stock = "inbound_stock"
//        case stock_on_hold = "stock_on_hold"
//        case sold_today = "sold_today"
//        case sales_last_days = "sales_last_days"
//        case reserved_stock = "reserved_stock"
//        case customer_returns = "customer_returns"
//        case warehouse_damage = "warehouse_damage"
//        case lost_in_post = "lost_in_post"
//        case other_logs = "other_logs"
//        case out_stock_days = "out_stock_days"
//        case lost_sales = "lost_sales"
//        case has_location = "has_location"
//        case update_date = "update_date"
//        case atum_locations = "atum_locations"
//        case atum_stock_status = "atum_stock_status"
//        case restock_status = "restock_status"
//        case sales_update_date = "sales_update_date"
//        case calc_backorders = "calc_backorders"
//        case yoast_head = "yoast_head"
//        case yoast_head_json = "yoast_head_json"
//        case _links = "_links"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        slug = try values.decodeIfPresent(String.self, forKey: .slug)
//        permalink = try values.decodeIfPresent(String.self, forKey: .permalink)
//        date_created = try values.decodeIfPresent(String.self, forKey: .date_created)
//        date_created_gmt = try values.decodeIfPresent(String.self, forKey: .date_created_gmt)
//        date_modified = try values.decodeIfPresent(String.self, forKey: .date_modified)
//        date_modified_gmt = try values.decodeIfPresent(String.self, forKey: .date_modified_gmt)
//        type = try values.decodeIfPresent(String.self, forKey: .type)
//        status = try values.decodeIfPresent(String.self, forKey: .status)
//        featured = try values.decodeIfPresent(Bool.self, forKey: .featured)
//        catalog_visibility = try values.decodeIfPresent(String.self, forKey: .catalog_visibility)
//        description = try values.decodeIfPresent(String.self, forKey: .description)
//        short_description = try values.decodeIfPresent(String.self, forKey: .short_description)
//        sku = try values.decodeIfPresent(String.self, forKey: .sku)
//        price = try values.decodeIfPresent(String.self, forKey: .price)
//        regular_price = try values.decodeIfPresent(String.self, forKey: .regular_price)
//        sale_price = try values.decodeIfPresent(String.self, forKey: .sale_price)
//        date_on_sale_from = try values.decodeIfPresent(String.self, forKey: .date_on_sale_from)
//        date_on_sale_from_gmt = try values.decodeIfPresent(String.self, forKey: .date_on_sale_from_gmt)
//        date_on_sale_to = try values.decodeIfPresent(String.self, forKey: .date_on_sale_to)
//        date_on_sale_to_gmt = try values.decodeIfPresent(String.self, forKey: .date_on_sale_to_gmt)
//        on_sale = try values.decodeIfPresent(Bool.self, forKey: .on_sale)
//        purchasable = try values.decodeIfPresent(Bool.self, forKey: .purchasable)
//        if let totalSales = try? values.decodeIfPresent(String.self, forKey: .total_sales){
//            total_sales = Int(totalSales)
//        }else{
//            total_sales = try values.decodeIfPresent(Int.self, forKey: .total_sales)
//        }
//        virtual = try values.decodeIfPresent(Bool.self, forKey: .virtual)
//        downloadable = try values.decodeIfPresent(Bool.self, forKey: .downloadable)
//        downloads = try values.decodeIfPresent([String].self, forKey: .downloads)
//        download_limit = try values.decodeIfPresent(Int.self, forKey: .download_limit)
//        download_expiry = try values.decodeIfPresent(Int.self, forKey: .download_expiry)
//        external_url = try values.decodeIfPresent(String.self, forKey: .external_url)
//        button_text = try values.decodeIfPresent(String.self, forKey: .button_text)
//        tax_status = try values.decodeIfPresent(String.self, forKey: .tax_status)
//        tax_class = try values.decodeIfPresent(String.self, forKey: .tax_class)
//        manage_stock = try values.decodeIfPresent(Bool.self, forKey: .manage_stock)
//        stock_quantity = try values.decodeIfPresent(Int.self, forKey: .stock_quantity)
//        in_stock = try values.decodeIfPresent(Bool.self, forKey: .in_stock)
//        backorders = try values.decodeIfPresent(String.self, forKey: .backorders)
//        backorders_allowed = try values.decodeIfPresent(Bool.self, forKey: .backorders_allowed)
//        backordered = try values.decodeIfPresent(Bool.self, forKey: .backordered)
//        sold_individually = try values.decodeIfPresent(Bool.self, forKey: .sold_individually)
//        weight = try values.decodeIfPresent(String.self, forKey: .weight)
//        dimensions = try values.decodeIfPresent(Dimensions.self, forKey: .dimensions)
//        shipping_required = try values.decodeIfPresent(Bool.self, forKey: .shipping_required)
//        shipping_taxable = try values.decodeIfPresent(Bool.self, forKey: .shipping_taxable)
//        shipping_class = try values.decodeIfPresent(String.self, forKey: .shipping_class)
//        shipping_class_id = try values.decodeIfPresent(Int.self, forKey: .shipping_class_id)
//        reviews_allowed = try values.decodeIfPresent(Bool.self, forKey: .reviews_allowed)
//        average_rating = try values.decodeIfPresent(String.self, forKey: .average_rating)
//        rating_count = try values.decodeIfPresent(Int.self, forKey: .rating_count)
//        upsell_ids = try values.decodeIfPresent([Int].self, forKey: .upsell_ids)
//        cross_sell_ids = try values.decodeIfPresent([Int].self, forKey: .cross_sell_ids)
//        parent_id = try values.decodeIfPresent(Int.self, forKey: .parent_id)
//        purchase_note = try values.decodeIfPresent(String.self, forKey: .purchase_note)
//        categories = try values.decodeIfPresent([Categories].self, forKey: .categories)
//        tags = try values.decodeIfPresent([Categories].self, forKey: .tags)
//        images = try values.decodeIfPresent([ProductImages].self, forKey: .images)
//        attributes = try values.decodeIfPresent([Attributes].self, forKey: .attributes)
//        default_attributes = try values.decodeIfPresent([DefaultAttributes].self, forKey: .default_attributes)
//        variations = try values.decodeIfPresent([Int].self, forKey: .variations)
//        grouped_products = try values.decodeIfPresent([String].self, forKey: .grouped_products)
//        menu_order = try values.decodeIfPresent(Int.self, forKey: .menu_order)
//        low_stock_amount = try values.decodeIfPresent(IDQuantumValue.self, forKey: .low_stock_amount)
//        price_html = try values.decodeIfPresent(String.self, forKey: .price_html)
//        related_ids = try values.decodeIfPresent([Int].self, forKey: .related_ids)
//        meta_data = try values.decodeIfPresent([Meta_data].self, forKey: .meta_data)
//        purchase_price = try values.decodeIfPresent(String.self, forKey: .purchase_price)
//        supplier_id = try values.decodeIfPresent(String.self, forKey: .supplier_id)
//        supplier_sku = try values.decodeIfPresent(String.self, forKey: .supplier_sku)
//        barcode = try values.decodeIfPresent(String.self, forKey: .barcode)
//        atum_controlled = try values.decodeIfPresent(Bool.self, forKey: .atum_controlled)
//        out_stock_date = try values.decodeIfPresent(String.self, forKey: .out_stock_date)
//        out_stock_threshold = try values.decodeIfPresent(String.self, forKey: .out_stock_threshold)
//        inheritable = try values.decodeIfPresent(Bool.self, forKey: .inheritable)
//        inbound_stock = try values.decodeIfPresent(Int.self, forKey: .inbound_stock)
//        stock_on_hold = try values.decodeIfPresent(Int.self, forKey: .stock_on_hold)
//        sold_today = try values.decodeIfPresent(Int.self, forKey: .sold_today)
//        sales_last_days = try values.decodeIfPresent(Int.self, forKey: .sales_last_days)
//        reserved_stock = try values.decodeIfPresent(Int.self, forKey: .reserved_stock)
//        customer_returns = try values.decodeIfPresent(Int.self, forKey: .customer_returns)
//        warehouse_damage = try values.decodeIfPresent(Int.self, forKey: .warehouse_damage)
//        lost_in_post = try values.decodeIfPresent(Int.self, forKey: .lost_in_post)
//        other_logs = try values.decodeIfPresent(Int.self, forKey: .other_logs)
//        out_stock_days = try values.decodeIfPresent(Int.self, forKey: .out_stock_days)
//        lost_sales = try values.decodeIfPresent(Int.self, forKey: .lost_sales)
//        has_location = try values.decodeIfPresent(Bool.self, forKey: .has_location)
//        update_date = try values.decodeIfPresent(String.self, forKey: .update_date)
//        atum_locations = try values.decodeIfPresent([String].self, forKey: .atum_locations)
//        atum_stock_status = try values.decodeIfPresent(String.self, forKey: .atum_stock_status)
//        restock_status = try values.decodeIfPresent(Bool.self, forKey: .restock_status)
//        sales_update_date = try values.decodeIfPresent(String.self, forKey: .sales_update_date)
//        calc_backorders = try values.decodeIfPresent(String.self, forKey: .calc_backorders)
//        yoast_head = try values.decodeIfPresent(String.self, forKey: .yoast_head)
//        yoast_head_json = try values.decodeIfPresent(YoastHeadJson.self, forKey: .yoast_head_json)
//        _links = try values.decodeIfPresent(Links.self, forKey: ._links)
//    }
//}

struct Links : Codable {
//    let productSelf : [ProductSelf]?
//    let collection : [ProductCollection]?
//    
//    enum CodingKeys: String, CodingKey {
//        case productSelf = "self"
//        case collection = "collection"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        productSelf = try values.decodeIfPresent([ProductSelf].self, forKey: .productSelf)
//        collection = try values.decodeIfPresent([ProductCollection].self, forKey: .collection)
//    }
}

struct ProductGraph : Codable {
    let type : String?
    let id : String?
    let url : String?
    let name : String?
    let isPartOf : IsPartOf?
    let primaryImageOfPage : PrimaryImageOfPage?
    let image : ProductImage?
    let thumbnailUrl : String?
    let datePublished : String?
    let dateModified : String?
    let description : String?
    let breadcrumb : Breadcrumb?
    let inLanguage : String?
    let potentialAction : [PotentialAction]?

    enum CodingKeys: String, CodingKey {

        case type = "@type"
        case id = "@id"
        case url = "url"
        case name = "name"
        case isPartOf = "isPartOf"
        case primaryImageOfPage = "primaryImageOfPage"
        case image = "image"
        case thumbnailUrl = "thumbnailUrl"
        case datePublished = "datePublished"
        case dateModified = "dateModified"
        case description = "description"
        case breadcrumb = "breadcrumb"
        case inLanguage = "inLanguage"
        case potentialAction = "potentialAction"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        isPartOf = try values.decodeIfPresent(IsPartOf.self, forKey: .isPartOf)
        primaryImageOfPage = try values.decodeIfPresent(PrimaryImageOfPage.self, forKey: .primaryImageOfPage)
        image = try values.decodeIfPresent(ProductImage.self, forKey: .image)
        thumbnailUrl = try values.decodeIfPresent(String.self, forKey: .thumbnailUrl)
        datePublished = try values.decodeIfPresent(String.self, forKey: .datePublished)
        dateModified = try values.decodeIfPresent(String.self, forKey: .dateModified)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        breadcrumb = try values.decodeIfPresent(Breadcrumb.self, forKey: .breadcrumb)
        inLanguage = try values.decodeIfPresent(String.self, forKey: .inLanguage)
        potentialAction = try values.decodeIfPresent([PotentialAction].self, forKey: .potentialAction)
    }

}

struct Attributes : Codable {
    let id : Int?
    let name : String?
    let slug : String?
    let position : Int?
    let visible : Bool?
    let variation : Bool?
    let options : [String]?
    let option_ids : [String]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case slug = "slug"
        case position = "position"
        case visible = "visible"
        case variation = "variation"
        case options = "options"
        case option_ids = "option_ids"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        position = try values.decodeIfPresent(Int.self, forKey: .position)
        visible = try values.decodeIfPresent(Bool.self, forKey: .visible)
        variation = try values.decodeIfPresent(Bool.self, forKey: .variation)
        options = try values.decodeIfPresent([String].self, forKey: .options)
        option_ids = try values.decodeIfPresent([String].self, forKey: .option_ids)
    }

}

struct DefaultAttributes : Codable {
    let id : Int?
    let name : String?
    let option : String?
//    let position : Int?
//    let visible : Bool?
//    let variation : Bool?
//    let options : [String]?
//    let option_ids : [String]?

//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case name = "name"
//        case slug = "slug"
//        case position = "position"
//        case visible = "visible"
//        case variation = "variation"
//        case options = "options"
//        case option_ids = "option_ids"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        slug = try values.decodeIfPresent(String.self, forKey: .slug)
//        position = try values.decodeIfPresent(Int.self, forKey: .position)
//        visible = try values.decodeIfPresent(Bool.self, forKey: .visible)
//        variation = try values.decodeIfPresent(Bool.self, forKey: .variation)
//        options = try values.decodeIfPresent([String].self, forKey: .options)
//        option_ids = try values.decodeIfPresent([String].self, forKey: .option_ids)
//    }

}

struct Breadcrumb : Codable {
    let id : String?

    enum CodingKeys: String, CodingKey {

        case id = "@id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
    }

}

struct Categories : Codable {
    let id : Int?
    let name : String?
    let slug : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case name = "name"
//        case slug = "slug"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        slug = try values.decodeIfPresent(String.self, forKey: .slug)
//    }

}

struct ProductCollection : Codable {
    let href : String?

    enum CodingKeys: String, CodingKey {

        case href = "href"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        href = try values.decodeIfPresent(String.self, forKey: .href)
    }

}

struct Dimensions : Codable {
//    let length : String?
//    let width : String?
//    let height : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case length = "length"
//        case width = "width"
//        case height = "height"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        length = try values.decodeIfPresent(String.self, forKey: .length)
//        width = try values.decodeIfPresent(String.self, forKey: .width)
//        height = try values.decodeIfPresent(String.self, forKey: .height)
//    }

}

struct ProductImage : Codable {
    let id : String?

    enum CodingKeys: String, CodingKey {

        case id = "@id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
    }

}

struct ProductImages : Codable {
    let id : Int?
    let date_created : String?
    let date_created_gmt : String?
    let date_modified : String?
    let date_modified_gmt : String?
    let src : String?
    let name : String?
    let alt : String?
    let position : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case date_created = "date_created"
        case date_created_gmt = "date_created_gmt"
        case date_modified = "date_modified"
        case date_modified_gmt = "date_modified_gmt"
        case src = "src"
        case name = "name"
        case alt = "alt"
        case position = "position"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        date_created = try values.decodeIfPresent(String.self, forKey: .date_created)
        date_created_gmt = try values.decodeIfPresent(String.self, forKey: .date_created_gmt)
        date_modified = try values.decodeIfPresent(String.self, forKey: .date_modified)
        date_modified_gmt = try values.decodeIfPresent(String.self, forKey: .date_modified_gmt)
        src = try values.decodeIfPresent(String.self, forKey: .src)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        alt = try values.decodeIfPresent(String.self, forKey: .alt)
        position = try values.decodeIfPresent(Int.self, forKey: .position)
    }

}


struct IsPartOf : Codable {
    let id : String?

    enum CodingKeys: String, CodingKey {

        case id = "@id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
    }

}


struct Meta_data : Codable {
//    let id : Int?
//    let key : String?
//    let value : MetaDataQuantumValue?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case key = "key"
//        case value = "value"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        key = try values.decodeIfPresent(String.self, forKey: .key)
//        value = try values.decodeIfPresent(MetaDataQuantumValue.self, forKey: .value)
//    }

}

struct OgImage : Codable {
    let width : Int?
    let height : Int?
    let url : String?
    let type : String?

    enum CodingKeys: String, CodingKey {

        case width = "width"
        case height = "height"
        case url = "url"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }

}


struct PotentialAction : Codable {
    let type : String?
    let target : [String]?

    enum CodingKeys: String, CodingKey {

        case type = "@type"
        case target = "target"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        target = try values.decodeIfPresent([String].self, forKey: .target)
    }

}

struct PrimaryImageOfPage : Codable {
    let id : String?

    enum CodingKeys: String, CodingKey {

        case id = "@id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
    }

}

struct Robots : Codable {
//    let index : String?
//    let follow : String?
//    let maxsnippet : String?
//    let maximagepreview : String?
//    let maxvideopreview : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case index = "index"
//        case follow = "follow"
//        case maxsnippet = "max-snippet"
//        case maximagepreview = "max-image-preview"
//        case maxvideopreview = "max-video-preview"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        index = try values.decodeIfPresent(String.self, forKey: .index)
//        follow = try values.decodeIfPresent(String.self, forKey: .follow)
//        maxsnippet = try values.decodeIfPresent(String.self, forKey: .maxsnippet)
//        maximagepreview = try values.decodeIfPresent(String.self, forKey: .maximagepreview)
//        maxvideopreview = try values.decodeIfPresent(String.self, forKey: .maxvideopreview)
//    }

}

struct ProductSchema : Codable {
//    let context : String?
//    let graph : [ProductGraph]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case context = "@context"
//        case graph = "@graph"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        context = try values.decodeIfPresent(String.self, forKey: .context)
//        graph = try values.decodeIfPresent([ProductGraph].self, forKey: .graph)
//    }

}

struct ProductSelf : Codable {
    let href : String?

    enum CodingKeys: String, CodingKey {

        case href = "href"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        href = try values.decodeIfPresent(String.self, forKey: .href)
    }

}

struct Twitter_misc : Codable {
//    let estreadingtime : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case estreadingtime = "Est. reading time"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        estreadingtime = try values.decodeIfPresent(String.self, forKey: .estreadingtime)
//    }

}



struct YoastHeadJson : Codable {
    let title : String?
    let description : String?
    let robots : Robots?
    let canonical : String?
    let og_locale : String?
    let og_type : String?
    let og_title : String?
    let og_description : String?
    let og_url : String?
    let og_site_name : String?
    let article_modified_time : String?
    let og_image : [OgImage]?
    let twitter_card : String?
    let twitter_misc : Twitter_misc?
    let schema : ProductSchema?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case description = "description"
        case robots = "robots"
        case canonical = "canonical"
        case og_locale = "og_locale"
        case og_type = "og_type"
        case og_title = "og_title"
        case og_description = "og_description"
        case og_url = "og_url"
        case og_site_name = "og_site_name"
        case article_modified_time = "article_modified_time"
        case og_image = "og_image"
        case twitter_card = "twitter_card"
        case twitter_misc = "twitter_misc"
        case schema = "schema"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        robots = try values.decodeIfPresent(Robots.self, forKey: .robots)
        canonical = try values.decodeIfPresent(String.self, forKey: .canonical)
        og_locale = try values.decodeIfPresent(String.self, forKey: .og_locale)
        og_type = try values.decodeIfPresent(String.self, forKey: .og_type)
        og_title = try values.decodeIfPresent(String.self, forKey: .og_title)
        og_description = try values.decodeIfPresent(String.self, forKey: .og_description)
        og_url = try values.decodeIfPresent(String.self, forKey: .og_url)
        og_site_name = try values.decodeIfPresent(String.self, forKey: .og_site_name)
        article_modified_time = try values.decodeIfPresent(String.self, forKey: .article_modified_time)
        og_image = try values.decodeIfPresent([OgImage].self, forKey: .og_image)
        twitter_card = try values.decodeIfPresent(String.self, forKey: .twitter_card)
        twitter_misc = try values.decodeIfPresent(Twitter_misc.self, forKey: .twitter_misc)
        schema = try values.decodeIfPresent(ProductSchema.self, forKey: .schema)
    }

}



//struct ProductListModel : Codable {
//    let id : Int?
//    let date : String?
//    let date_gmt : String?
//    let guid : Guid?
//    let modified : String?
//    let modified_gmt : String?
//    let slug : String?
//    let status : String?
//    let type : String?
//    let link : String?
//    let title : ProductTitle?
//    let content : ProductContent?
//    let excerpt : Excerpt?
//    let featured_media : Int?
//    let template : String?
//    let meta : ProductMeta?
//    let product_cat : [Int]?
//    let product_tag : [String]?
//    let supplier_id : String?
//    let supplier_sku : String?
//    let barcode : String?
//    let atum_controlled : Bool?
//    let out_stock_date : String?
//    let out_stock_threshold : String?
//    let inheritable : Bool?
//    let inbound_stock : Int?
//    let stock_on_hold : Int?
//    let sold_today : Int?
//    let sales_last_days : Int?
//    let reserved_stock : Int?
//    let customer_returns : Int?
//    let warehouse_damage : Int?
//    let lost_in_post : Int?
//    let other_logs : Int?
//    let out_stock_days : Int?
//    let lost_sales : Int?
//    let has_location : Bool?
//    let update_date : String?
//    let atum_locations : [String]?
//    let atum_stock_status : String?
//    let restock_status : Bool?
//    let low_stock_amount : String?
//    let sales_update_date : String?
//    let calc_backorders : String?
//    let yoast_head : String?
//    let yoast_head_json : YoastHeadJson?
//    let _links : Links?
//    
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case date = "date"
//        case date_gmt = "date_gmt"
//        case guid = "guid"
//        case modified = "modified"
//        case modified_gmt = "modified_gmt"
//        case slug = "slug"
//        case status = "status"
//        case type = "type"
//        case link = "link"
//        case title = "title"
//        case content = "content"
//        case excerpt = "excerpt"
//        case featured_media = "featured_media"
//        case template = "template"
//        case meta = "meta"
//        case product_cat = "product_cat"
//        case product_tag = "product_tag"
//        case supplier_id = "supplier_id"
//        case supplier_sku = "supplier_sku"
//        case barcode = "barcode"
//        case atum_controlled = "atum_controlled"
//        case out_stock_date = "out_stock_date"
//        case out_stock_threshold = "out_stock_threshold"
//        case inheritable = "inheritable"
//        case inbound_stock = "inbound_stock"
//        case stock_on_hold = "stock_on_hold"
//        case sold_today = "sold_today"
//        case sales_last_days = "sales_last_days"
//        case reserved_stock = "reserved_stock"
//        case customer_returns = "customer_returns"
//        case warehouse_damage = "warehouse_damage"
//        case lost_in_post = "lost_in_post"
//        case other_logs = "other_logs"
//        case out_stock_days = "out_stock_days"
//        case lost_sales = "lost_sales"
//        case has_location = "has_location"
//        case update_date = "update_date"
//        case atum_locations = "atum_locations"
//        case atum_stock_status = "atum_stock_status"
//        case restock_status = "restock_status"
//        case low_stock_amount = "low_stock_amount"
//        case sales_update_date = "sales_update_date"
//        case calc_backorders = "calc_backorders"
//        case yoast_head = "yoast_head"
//        case yoast_head_json = "yoast_head_json"
//        case _links = "_links"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        date = try values.decodeIfPresent(String.self, forKey: .date)
//        date_gmt = try values.decodeIfPresent(String.self, forKey: .date_gmt)
//        guid = try values.decodeIfPresent(Guid.self, forKey: .guid)
//        modified = try values.decodeIfPresent(String.self, forKey: .modified)
//        modified_gmt = try values.decodeIfPresent(String.self, forKey: .modified_gmt)
//        slug = try values.decodeIfPresent(String.self, forKey: .slug)
//        status = try values.decodeIfPresent(String.self, forKey: .status)
//        type = try values.decodeIfPresent(String.self, forKey: .type)
//        link = try values.decodeIfPresent(String.self, forKey: .link)
//        title = try values.decodeIfPresent(ProductTitle.self, forKey: .title)
//        content = try values.decodeIfPresent(ProductContent.self, forKey: .content)
//        excerpt = try values.decodeIfPresent(Excerpt.self, forKey: .excerpt)
//        featured_media = try values.decodeIfPresent(Int.self, forKey: .featured_media)
//        template = try values.decodeIfPresent(String.self, forKey: .template)
//        meta = try values.decodeIfPresent(ProductMeta.self, forKey: .meta)
//        product_cat = try values.decodeIfPresent([Int].self, forKey: .product_cat)
//        product_tag = try values.decodeIfPresent([String].self, forKey: .product_tag)
//        supplier_id = try values.decodeIfPresent(String.self, forKey: .supplier_id)
//        supplier_sku = try values.decodeIfPresent(String.self, forKey: .supplier_sku)
//        barcode = try values.decodeIfPresent(String.self, forKey: .barcode)
//        atum_controlled = try values.decodeIfPresent(Bool.self, forKey: .atum_controlled)
//        out_stock_date = try values.decodeIfPresent(String.self, forKey: .out_stock_date)
//        out_stock_threshold = try values.decodeIfPresent(String.self, forKey: .out_stock_threshold)
//        inheritable = try values.decodeIfPresent(Bool.self, forKey: .inheritable)
//        inbound_stock = try values.decodeIfPresent(Int.self, forKey: .inbound_stock)
//        stock_on_hold = try values.decodeIfPresent(Int.self, forKey: .stock_on_hold)
//        sold_today = try values.decodeIfPresent(Int.self, forKey: .sold_today)
//        sales_last_days = try values.decodeIfPresent(Int.self, forKey: .sales_last_days)
//        reserved_stock = try values.decodeIfPresent(Int.self, forKey: .reserved_stock)
//        customer_returns = try values.decodeIfPresent(Int.self, forKey: .customer_returns)
//        warehouse_damage = try values.decodeIfPresent(Int.self, forKey: .warehouse_damage)
//        lost_in_post = try values.decodeIfPresent(Int.self, forKey: .lost_in_post)
//        other_logs = try values.decodeIfPresent(Int.self, forKey: .other_logs)
//        out_stock_days = try values.decodeIfPresent(Int.self, forKey: .out_stock_days)
//        lost_sales = try values.decodeIfPresent(Int.self, forKey: .lost_sales)
//        has_location = try values.decodeIfPresent(Bool.self, forKey: .has_location)
//        update_date = try values.decodeIfPresent(String.self, forKey: .update_date)
//        atum_locations = try values.decodeIfPresent([String].self, forKey: .atum_locations)
//        atum_stock_status = try values.decodeIfPresent(String.self, forKey: .atum_stock_status)
//        restock_status = try values.decodeIfPresent(Bool.self, forKey: .restock_status)
//        low_stock_amount = try values.decodeIfPresent(String.self, forKey: .low_stock_amount)
//        sales_update_date = try values.decodeIfPresent(String.self, forKey: .sales_update_date)
//        calc_backorders = try values.decodeIfPresent(String.self, forKey: .calc_backorders)
//        yoast_head = try values.decodeIfPresent(String.self, forKey: .yoast_head)
//        yoast_head_json = try values.decodeIfPresent(YoastHeadJson.self, forKey: .yoast_head_json)
//        _links = try values.decodeIfPresent(Links.self, forKey: ._links)
//    }
//}
//
//struct Links : Codable {
////    let selfData : [ProductSelf]?
////    let collection : [ProductCollection]?
////    let about : [About]?
////    let wpFeaturedmedia : [WpFeaturedmedia]?
////    let wpAttachment : [WpAttachment]?
////    let wpTerm : [WpTerm]?
////    let curies : [Curies]?
//}
////
//struct ProductGraph : Codable {
//    let type : String?
//    let id : String?
//    let url : String?
//    let name : String?
//    let isPartOf : IsPartOf?
//    let primaryImageOfPage : PrimaryImageOfPage?
//    let image : ProductImage?
//    let thumbnailUrl : String?
//    let datePublished : String?
//    let dateModified : String?
//    let description : String?
//    let breadcrumb : Breadcrumb?
//    let inLanguage : String?
//    let potentialAction : [PotentialAction]?
//}
//
//struct About : Codable {
//    let href : String?
//}
//
//struct Breadcrumb : Codable {
//    let id : String?
//    enum CodingKeys: String, CodingKey {
//        case id = "@id"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//    }
//}
//
//struct ProductCollection : Codable {
//    let href : String?
//}
//
//struct ProductContent : Codable {
//    let rendered : String?
//    let protected : Bool?
//}
//
//struct Curies : Codable {
//    let name : String?
//    let href : String?
//    let templated : Bool?
//}
//
//struct Excerpt : Codable {
//    let rendered : String?
//    let protected : Bool?
//}
//
//struct Guid : Codable {
//    let rendered : String?
//}
//
//struct ProductImage : Codable {
//    let id : String?
//    enum CodingKeys: String, CodingKey {
//        case id = "@id"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//    }
//}
//
//struct IsPartOf : Codable {
//    let id : String?
//    enum CodingKeys: String, CodingKey {
//        case id = "@id"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//    }
//}
//
//struct ProductMeta : Codable {
//    let _et_pb_use_builder : String?
//    let _et_pb_old_content : String?
//    let _et_gb_content_width : String?
//}
//
//struct OgImage : Codable {
//    let width : Int?
//    let height : Int?
//    let url : String?
//    let type : String?
//}
//
//struct PotentialAction : Codable {
//    let type : String?
//    let target : [String]?
//    enum CodingKeys: String, CodingKey {
//        case type = "@type"
//        case target = "target"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        type = try values.decodeIfPresent(String.self, forKey: .type)
//        target = try values.decodeIfPresent([String].self, forKey: .target)
//    }
//}
//
//struct PrimaryImageOfPage : Codable {
//    let id : String?
//    enum CodingKeys: String, CodingKey {
//        case id = "@id"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//    }
//}
////
//struct Robots : Codable {
////    let index : String?
////    let follow : String?
////    let maxsnippet : String?
////    let maximagepreview : String?
////    let maxvideopreview : String?
////    enum CodingKeys: String, CodingKey {
////
////        case index = "index"
////        case follow = "follow"
////        case maxsnippet = "max-snippet"
////        case maximagepreview = "max-image-preview"
////        case maxvideopreview = "max-video-preview"
////    }
////
////    init(from decoder: Decoder) throws {
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        index = try values.decodeIfPresent(String.self, forKey: .index)
////        follow = try values.decodeIfPresent(String.self, forKey: .follow)
////        maxsnippet = try values.decodeIfPresent(String.self, forKey: .maxsnippet)
////        maximagepreview = try values.decodeIfPresent(String.self, forKey: .maximagepreview)
////        maxvideopreview = try values.decodeIfPresent(String.self, forKey: .maxvideopreview)
////    }
//}
////
//struct ProductSchema : Codable {
////    let context : String?
////    let graph : [ProductGraph]?
////    enum CodingKeys: String, CodingKey {
////        case context = "@context"
////        case graph = "@graph"
////    }
////
////    init(from decoder: Decoder) throws {
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        context = try values.decodeIfPresent(String.self, forKey: .context)
////        graph = try values.decodeIfPresent([ProductGraph].self, forKey: .graph)
////    }
//}
////
//struct ProductSelf : Codable {
//    let href : String?
//}
////
//struct ProductTitle : Codable {
//    let rendered : String?
//}
////
//struct TwitterMisc : Codable {
////    let estreadingtime : String?
////    enum CodingKeys: String, CodingKey {
////        case estreadingtime = "Est. reading time"
////    }
////
////    init(from decoder: Decoder) throws {
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        estreadingtime = try values.decodeIfPresent(String.self, forKey: .estreadingtime)
////    }
//}
////
//struct WpAttachment : Codable {
//    let href : String?
//}
//
//struct WpFeaturedmedia : Codable {
//    let embeddable : Bool?
//    let href : String?
//    
//}
//
//struct WpTerm : Codable {
//    let taxonomy : String?
//    let embeddable : Bool?
//    let href : String?
//}
////
//struct YoastHeadJson : Codable {
//    let title : String?
//    let description : String?
//    let robots : Robots?
//    let canonical : String?
//    let og_locale : String?
//    let og_type : String?
//    let og_title : String?
//    let og_description : String?
//    let og_url : String?
//    let og_site_name : String?
//    let article_modified_time : String?
//    let og_image : [OgImage]?
//    let twitter_card : String?
//    let twitter_misc : TwitterMisc?
//    let schema : ProductSchema?
//}
