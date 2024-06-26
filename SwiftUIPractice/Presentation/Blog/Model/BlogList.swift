
import Foundation

struct BlogBaseModel : Codable {
    let id : Int?
    let date : String?
    let date_gmt : String?
    let guid : Guid?
    let modified : String?
    let modified_gmt : String?
    let slug : String?
    let status : String?
    let type : String?
    let link : String?
    let title : Guid?
    let content : BlogContent?
    let excerpt : BlogContent?
    let author : Int?
    let featured_media : Int?
    let comment_status : String?
    let ping_status : String?
    let sticky : Bool?
    let template : String?
    let format : String?
    let meta : Meta?
    let categories : [Int]?
    let tags : [Int]?
    let yoast_head : String?
    let yoast_head_json : YoastHeadJson?
    let _links : Links?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case date = "date"
        case date_gmt = "date_gmt"
        case guid = "guid"
        case modified = "modified"
        case modified_gmt = "modified_gmt"
        case slug = "slug"
        case status = "status"
        case type = "type"
        case link = "link"
        case title = "title"
        case content = "content"
        case excerpt = "excerpt"
        case author = "author"
        case featured_media = "featured_media"
        case comment_status = "comment_status"
        case ping_status = "ping_status"
        case sticky = "sticky"
        case template = "template"
        case format = "format"
        case meta = "meta"
        case categories = "categories"
        case tags = "tags"
        case yoast_head = "yoast_head"
        case yoast_head_json = "yoast_head_json"
        case _links = "_links"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        date_gmt = try values.decodeIfPresent(String.self, forKey: .date_gmt)
        guid = try values.decodeIfPresent(Guid.self, forKey: .guid)
        modified = try values.decodeIfPresent(String.self, forKey: .modified)
        modified_gmt = try values.decodeIfPresent(String.self, forKey: .modified_gmt)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        link = try values.decodeIfPresent(String.self, forKey: .link)
        title = try values.decodeIfPresent(Guid.self, forKey: .title)
        content = try values.decodeIfPresent(BlogContent.self, forKey: .content)
        excerpt = try values.decodeIfPresent(BlogContent.self, forKey: .excerpt)
        author = try values.decodeIfPresent(Int.self, forKey: .author)
        featured_media = try values.decodeIfPresent(Int.self, forKey: .featured_media)
        comment_status = try values.decodeIfPresent(String.self, forKey: .comment_status)
        ping_status = try values.decodeIfPresent(String.self, forKey: .ping_status)
        sticky = try values.decodeIfPresent(Bool.self, forKey: .sticky)
        template = try values.decodeIfPresent(String.self, forKey: .template)
        format = try values.decodeIfPresent(String.self, forKey: .format)
        meta = try values.decodeIfPresent(Meta.self, forKey: .meta)
        categories = try values.decodeIfPresent([Int].self, forKey: .categories)
        tags = try values.decodeIfPresent([Int].self, forKey: .tags)
        yoast_head = try values.decodeIfPresent(String.self, forKey: .yoast_head)
        yoast_head_json = try values.decodeIfPresent(YoastHeadJson.self, forKey: .yoast_head_json)
        _links = try values.decodeIfPresent(Links.self, forKey: ._links)
    }

}

struct Guid : Codable {
    let rendered : String?
}

struct BlogContent : Codable {
    let rendered : String?
    let protected : Bool?
}

struct BlogYoastHeadJson : Codable {

}
