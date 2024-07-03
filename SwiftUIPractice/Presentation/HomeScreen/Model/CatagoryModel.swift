
import Foundation

struct CatagoryModel : Codable {
    let iD : Int?
    let name : String?
    let slug : String?
    let description : String?
    let count : Int?
    let items : [Items]?
    let meta : MenuMeta?
    
    enum CodingKeys: String, CodingKey {
        
        case iD = "ID"
        case name = "name"
        case slug = "slug"
        case description = "description"
        case count = "count"
        case items = "items"
        case meta = "meta"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iD = try values.decodeIfPresent(Int.self, forKey: .iD)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        items = try values.decodeIfPresent([Items].self, forKey: .items)
        meta = try values.decodeIfPresent(MenuMeta.self, forKey: .meta)
    }
    
}

struct Items : Codable {
    let id : Int?
    let order : Int?
    let parent : Int?
    let title : String?
    let url : String?
    let attr : String?
    let target : String?
    let classes : String?
    let xfn : String?
    let description : String?
    let object_id : Int?
    let object : String?
    let object_slug : String?
    let type : String?
    let type_label : String?
    let children: [MenuChildren]?
}

struct MenuMeta : Codable {
    let links : MenuLinks?
}

struct MenuLinks : Codable {
    let collection : String?
    let selfMenu : String?
    
    enum CodingKeys: String, CodingKey {

        case collection = "collection"
        case selfMenu = "self"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        collection = try values.decodeIfPresent(String.self, forKey: .collection)
        selfMenu = try values.decodeIfPresent(String.self, forKey: .selfMenu)
    }

}

struct MenuChildren : Codable {
    let id : Int?
    let order : Int?
    let parent : Int?
    let title : String?
    let url : String?
    let attr : String?
    let target : String?
    let classes : String?
    let xfn : String?
    let description : String?
    let object_id : Int?
    let object : String?
    let object_slug : String?
    let type : String?
    let type_label : String?
}

struct MenuObject: Codable {
    var id = UUID()
    var menuName : String
    var subMenus : [MenuChildren]
    var expandMe : Bool
}
