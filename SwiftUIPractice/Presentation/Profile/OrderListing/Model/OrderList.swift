
import Foundation

struct OrderList : Codable {
    let id : Int?
    let parent_id : Int?
    let status : String?
    let currency : String?
    let version : String?
    let prices_include_tax : Bool?
    let date_created : String?
    let date_modified : String?
    let discount_total : String?
    let discount_tax : String?
    let shipping_total : String?
    let shipping_tax : String?
    let cart_tax : String?
    let total : String?
    let total_tax : String?
    let customer_id : Int?
    let order_key : String?
    let billing : Shipping?
    let shipping : Shipping?
    let payment_method : String?
    let payment_method_title : String?
    let transaction_id : String?
    let customer_ip_address : String?
    let customer_user_agent : String?
    let created_via : String?
    let customer_note : String?
    let date_completed : String?
    let date_paid : String?
    let cart_hash : String?
    let number : String?
    let meta_data : [Meta_data]?
    let line_items : [LineItems]?
    let tax_lines : [TaxLines]?
    let shipping_lines : [Shipping_lines]?
    let fee_lines : [String]?
    let coupon_lines : [Coupon_lines]?
    let refunds : [String]?
    let payment_url : String?
    let is_editable : Bool?
    let needs_payment : Bool?
    let needs_processing : Bool?
    let date_created_gmt : String?
    let date_modified_gmt : String?
    let date_completed_gmt : String?
    let date_paid_gmt : String?
    let currency_symbol : String?
    let _links : OrderLinks?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case parent_id = "parent_id"
        case status = "status"
        case currency = "currency"
        case version = "version"
        case prices_include_tax = "prices_include_tax"
        case date_created = "date_created"
        case date_modified = "date_modified"
        case discount_total = "discount_total"
        case discount_tax = "discount_tax"
        case shipping_total = "shipping_total"
        case shipping_tax = "shipping_tax"
        case cart_tax = "cart_tax"
        case total = "total"
        case total_tax = "total_tax"
        case customer_id = "customer_id"
        case order_key = "order_key"
        case billing = "billing"
        case shipping = "shipping"
        case payment_method = "payment_method"
        case payment_method_title = "payment_method_title"
        case transaction_id = "transaction_id"
        case customer_ip_address = "customer_ip_address"
        case customer_user_agent = "customer_user_agent"
        case created_via = "created_via"
        case customer_note = "customer_note"
        case date_completed = "date_completed"
        case date_paid = "date_paid"
        case cart_hash = "cart_hash"
        case number = "number"
        case meta_data = "meta_data"
        case line_items = "line_items"
        case tax_lines = "tax_lines"
        case shipping_lines = "shipping_lines"
        case fee_lines = "fee_lines"
        case coupon_lines = "coupon_lines"
        case refunds = "refunds"
        case payment_url = "payment_url"
        case is_editable = "is_editable"
        case needs_payment = "needs_payment"
        case needs_processing = "needs_processing"
        case date_created_gmt = "date_created_gmt"
        case date_modified_gmt = "date_modified_gmt"
        case date_completed_gmt = "date_completed_gmt"
        case date_paid_gmt = "date_paid_gmt"
        case currency_symbol = "currency_symbol"
        case _links = "_links"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        parent_id = try values.decodeIfPresent(Int.self, forKey: .parent_id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        version = try values.decodeIfPresent(String.self, forKey: .version)
        prices_include_tax = try values.decodeIfPresent(Bool.self, forKey: .prices_include_tax)
        date_created = try values.decodeIfPresent(String.self, forKey: .date_created)
        date_modified = try values.decodeIfPresent(String.self, forKey: .date_modified)
        discount_total = try values.decodeIfPresent(String.self, forKey: .discount_total)
        discount_tax = try values.decodeIfPresent(String.self, forKey: .discount_tax)
        shipping_total = try values.decodeIfPresent(String.self, forKey: .shipping_total)
        shipping_tax = try values.decodeIfPresent(String.self, forKey: .shipping_tax)
        cart_tax = try values.decodeIfPresent(String.self, forKey: .cart_tax)
        total = try values.decodeIfPresent(String.self, forKey: .total)
        total_tax = try values.decodeIfPresent(String.self, forKey: .total_tax)
        customer_id = try values.decodeIfPresent(Int.self, forKey: .customer_id)
        order_key = try values.decodeIfPresent(String.self, forKey: .order_key)
        billing = try values.decodeIfPresent(Shipping.self, forKey: .billing)
        shipping = try values.decodeIfPresent(Shipping.self, forKey: .shipping)
        payment_method = try values.decodeIfPresent(String.self, forKey: .payment_method)
        payment_method_title = try values.decodeIfPresent(String.self, forKey: .payment_method_title)
        transaction_id = try values.decodeIfPresent(String.self, forKey: .transaction_id)
        customer_ip_address = try values.decodeIfPresent(String.self, forKey: .customer_ip_address)
        customer_user_agent = try values.decodeIfPresent(String.self, forKey: .customer_user_agent)
        created_via = try values.decodeIfPresent(String.self, forKey: .created_via)
        customer_note = try values.decodeIfPresent(String.self, forKey: .customer_note)
        date_completed = try values.decodeIfPresent(String.self, forKey: .date_completed)
        date_paid = try values.decodeIfPresent(String.self, forKey: .date_paid)
        cart_hash = try values.decodeIfPresent(String.self, forKey: .cart_hash)
        number = try values.decodeIfPresent(String.self, forKey: .number)
        meta_data = try values.decodeIfPresent([Meta_data].self, forKey: .meta_data)
        line_items = try values.decodeIfPresent([LineItems].self, forKey: .line_items)
        tax_lines = try values.decodeIfPresent([TaxLines].self, forKey: .tax_lines)
        shipping_lines = try values.decodeIfPresent([Shipping_lines].self, forKey: .shipping_lines)
        fee_lines = try values.decodeIfPresent([String].self, forKey: .fee_lines)
        coupon_lines = try values.decodeIfPresent([Coupon_lines].self, forKey: .coupon_lines)
        refunds = try values.decodeIfPresent([String].self, forKey: .refunds)
        payment_url = try values.decodeIfPresent(String.self, forKey: .payment_url)
        is_editable = try values.decodeIfPresent(Bool.self, forKey: .is_editable)
        needs_payment = try values.decodeIfPresent(Bool.self, forKey: .needs_payment)
        needs_processing = try values.decodeIfPresent(Bool.self, forKey: .needs_processing)
        date_created_gmt = try values.decodeIfPresent(String.self, forKey: .date_created_gmt)
        date_modified_gmt = try values.decodeIfPresent(String.self, forKey: .date_modified_gmt)
        date_completed_gmt = try values.decodeIfPresent(String.self, forKey: .date_completed_gmt)
        date_paid_gmt = try values.decodeIfPresent(String.self, forKey: .date_paid_gmt)
        currency_symbol = try values.decodeIfPresent(String.self, forKey: .currency_symbol)
        _links = try values.decodeIfPresent(OrderLinks.self, forKey: ._links)
    }
}

struct LineItems : Codable {
    let id : Int?
    let name : String?
    let product_id : Int?
    let variation_id : Int?
    let quantity : Int?
    let tax_class : String?
    let subtotal : String?
    let subtotal_tax : String?
    let total : String?
    let total_tax : String?
    let taxes : [ProductTaxes]?
    let meta_data : [ProductMetaData]?
    let sku : String?
    let price : Double?
    let image : LineImage?
    let parent_name : String?
    
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case product_id = "product_id"
        case variation_id = "variation_id"
        case quantity = "quantity"
        case tax_class = "tax_class"
        case subtotal = "subtotal"
        case subtotal_tax = "subtotal_tax"
        case total = "total"
        case total_tax = "total_tax"
        case taxes = "taxes"
        case meta_data = "meta_data"
        case sku = "sku"
        case price = "price"
        case image = "image"
        case parent_name = "parent_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        product_id = try values.decodeIfPresent(Int.self, forKey: .product_id)
        variation_id = try values.decodeIfPresent(Int.self, forKey: .variation_id)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        tax_class = try values.decodeIfPresent(String.self, forKey: .tax_class)
        subtotal = try values.decodeIfPresent(String.self, forKey: .subtotal)
        subtotal_tax = try values.decodeIfPresent(String.self, forKey: .subtotal_tax)
        total = try values.decodeIfPresent(String.self, forKey: .total)
        total_tax = try values.decodeIfPresent(String.self, forKey: .total_tax)
        taxes = try values.decodeIfPresent([ProductTaxes].self, forKey: .taxes)
        meta_data = try values.decodeIfPresent([ProductMetaData].self, forKey: .meta_data)
        sku = try values.decodeIfPresent(String.self, forKey: .sku)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        image = try values.decodeIfPresent(LineImage.self, forKey: .image)
        parent_name = try values.decodeIfPresent(String.self, forKey: .parent_name)
    }
}

struct TaxLines : Codable {
    let id : Int?
    let rate_code : String?
    let rate_id : Int?
    let label : String?
    let compound : Bool?
    let tax_total : String?
    let shipping_tax_total : String?
    let rate_percent : Int?
    let meta_data : [ProductMetaData]?
    
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case rate_code = "rate_code"
        case rate_id = "rate_id"
        case label = "label"
        case compound = "compound"
        case tax_total = "tax_total"
        case shipping_tax_total = "shipping_tax_total"
        case rate_percent = "rate_percent"
        case meta_data = "meta_data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        rate_code = try values.decodeIfPresent(String.self, forKey: .rate_code)
        rate_id = try values.decodeIfPresent(Int.self, forKey: .rate_id)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        compound = try values.decodeIfPresent(Bool.self, forKey: .compound)
        tax_total = try values.decodeIfPresent(String.self, forKey: .tax_total)
        shipping_tax_total = try values.decodeIfPresent(String.self, forKey: .shipping_tax_total)
        rate_percent = try values.decodeIfPresent(Int.self, forKey: .rate_percent)
        meta_data = try values.decodeIfPresent([ProductMetaData].self, forKey: .meta_data)
    }
}

struct ProductTaxes : Codable {
    let id : Int?
    let total : String?
    let subtotal : String?
}

struct ProductMetaData : Codable {
//    let id : Int?
//    let key : String?
//    let value : String?
//    let display_key : String?
//    let display_value : String?
}

struct MetaDataValue : Codable {
    
}

struct LineImage : Codable {
    let id : IDQuantumValue?
    let src : String?
}

struct Shipping_lines : Codable {
    let id : Int?
    let method_title : String?
    let method_id : String?
    let instance_id : String?
    let total : String?
    let total_tax : String?
    let taxes : [Taxes]?
    let meta_data : [ProductMetaData]?
}

struct Taxes : Codable {
    let id : Int?
    let total : String?
    let subtotal : String?
}

struct Coupon_lines : Codable {
    let id : Int?
    let code : String?
    let discount : String?
    let discount_tax : String?
    let meta_data : [ProductMetaData]?
    let discount_type : String?
    let nominal_amount : Int?
    let free_shipping : Bool?
}

struct OrderLinks : Codable {
    let selfLink : [Customer]?
    let collection : [Customer]?
    let customer : [Customer]?

    enum CodingKeys: String, CodingKey {

        case selfLink = "self"
        case collection = "collection"
        case customer = "customer"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        selfLink = try values.decodeIfPresent([Customer].self, forKey: .selfLink)
        collection = try values.decodeIfPresent([Customer].self, forKey: .collection)
        customer = try values.decodeIfPresent([Customer].self, forKey: .customer)
    }

}

struct Customer : Codable {
    let href : String?
}

enum MetaDataQuantumValue: Codable {
    
    case other(MetaDataValue), string(String)
    
    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(MetaDataValue.self) {
            self = .other(int)
            return
        }
        
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }
        
        throw QuantumError.missingValue
    }
    
    enum QuantumError:Error {
        case missingValue
    }
}

enum IDQuantumValue: Codable {
    
    case int(Int), string(String)
    
    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(int)
            return
        }
        
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }
        
        throw QuantumError.missingValue
    }
    
    enum QuantumError:Error {
        case missingValue
    }
}
