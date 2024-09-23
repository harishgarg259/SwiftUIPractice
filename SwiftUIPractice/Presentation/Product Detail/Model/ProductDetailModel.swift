import Foundation


struct CartProduct : Codable,Identifiable {
    
    init() {
        
    }
    
    var id : Int?
    var variationID : Int?
    var name : String?
    var regular_price : String?
    var stock_quantity : Int?
    var date_created : String?
    var featured : Bool?
    var description : String?
    var price : String?
    var sale_price : String?
    var on_sale : Bool?
    var in_stock : Bool?
    var weight : String?
    var images : [ProductImages]?
    var attributes : [Attributes]?
    var categories : [Categories]?
    var price_html : String?
    var variations : [VariationModel]?
}
