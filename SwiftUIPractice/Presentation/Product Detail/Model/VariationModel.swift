import Foundation


struct VariationModel : Codable {
	let id : Int?
	let date_created : String?
	let price : String?
	let regular_price : String?
	let sale_price : String?
	let on_sale : Bool?
	let stock_quantity : Int?
	let in_stock : Bool?
	let weight : String?
	let image : VariationImage?
	let attributes : [VariationAttributes]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case date_created = "date_created"
		case price = "price"
		case regular_price = "regular_price"
		case sale_price = "sale_price"
		case on_sale = "on_sale"
		case stock_quantity = "stock_quantity"
		case in_stock = "in_stock"
		case weight = "weight"
		case image = "image"
		case attributes = "attributes"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		date_created = try values.decodeIfPresent(String.self, forKey: .date_created)
		price = try values.decodeIfPresent(String.self, forKey: .price)
		regular_price = try values.decodeIfPresent(String.self, forKey: .regular_price)
		sale_price = try values.decodeIfPresent(String.self, forKey: .sale_price)
		on_sale = try values.decodeIfPresent(Bool.self, forKey: .on_sale)
		stock_quantity = try values.decodeIfPresent(Int.self, forKey: .stock_quantity)
		in_stock = try values.decodeIfPresent(Bool.self, forKey: .in_stock)
		weight = try values.decodeIfPresent(String.self, forKey: .weight)
		image = try values.decodeIfPresent(VariationImage.self, forKey: .image)
		attributes = try values.decodeIfPresent([VariationAttributes].self, forKey: .attributes)
	}

}

struct VariationImage : Codable {
    let id : Int?
    let date_created : String?
    let date_created_gmt : String?
    let date_modified : String?
    let date_modified_gmt : String?
    let src : String?
    let name : String?
    let alt : String?
    let position : Int?
}

struct VariationAttributes : Codable {
    let id : Int?
    let name : String?
    let slug : String?
    let option : String?
}
