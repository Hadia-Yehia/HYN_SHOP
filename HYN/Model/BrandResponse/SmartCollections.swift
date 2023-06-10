//
//  SmartCollections.swift
//  HYN
//
//  Created by Nada youssef on 08/06/2023.
//

import Foundation


/*struct SmartCollectionsResult :Decodable{
    let success: Int
    let result: [SmartCollections]?
}*/

struct SmartCollectionsResult: Decodable {

    let smart_collections: [SmartCollections]?
    
    enum CodingKeys: String, CodingKey {
       
        case smart_collections
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
 
        smart_collections = try container.decodeIfPresent([SmartCollections].self, forKey: .smart_collections)
    }
}

struct SmartCollections: Codable {

  var id                : Int?     = nil
  var handle            : String?  = nil
  var title             : String?  = nil
  var updatedAt         : String?  = nil
  var bodyHtml          : String?  = nil
  var publishedAt       : String?  = nil
  var sortOrder         : String?  = nil
  var templateSuffix    : String?  = nil
  var disjunctive       : Bool?    = nil
  var rules             : [Rules]? = []
  var publishedScope    : String?  = nil
  var adminGraphqlApiId : String?  = nil
  var image             : Image?   = Image()

  enum CodingKeys: String, CodingKey {

    case id                = "id"
    case handle            = "handle"
    case title             = "title"
    case updatedAt         = "updated_at"
    case bodyHtml          = "body_html"
    case publishedAt       = "published_at"
    case sortOrder         = "sort_order"
    case templateSuffix    = "template_suffix"
    case disjunctive       = "disjunctive"
    case rules             = "rules"
    case publishedScope    = "published_scope"
    case adminGraphqlApiId = "admin_graphql_api_id"
    case image             = "image"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id                = try values.decodeIfPresent(Int.self     , forKey: .id                )
    handle            = try values.decodeIfPresent(String.self  , forKey: .handle            )
    title             = try values.decodeIfPresent(String.self  , forKey: .title             )
    updatedAt         = try values.decodeIfPresent(String.self  , forKey: .updatedAt         )
    bodyHtml          = try values.decodeIfPresent(String.self  , forKey: .bodyHtml          )
    publishedAt       = try values.decodeIfPresent(String.self  , forKey: .publishedAt       )
    sortOrder         = try values.decodeIfPresent(String.self  , forKey: .sortOrder         )
    templateSuffix    = try values.decodeIfPresent(String.self  , forKey: .templateSuffix    )
    disjunctive       = try values.decodeIfPresent(Bool.self    , forKey: .disjunctive       )
    rules             = try values.decodeIfPresent([Rules].self , forKey: .rules             )
    publishedScope    = try values.decodeIfPresent(String.self  , forKey: .publishedScope    )
    adminGraphqlApiId = try values.decodeIfPresent(String.self  , forKey: .adminGraphqlApiId )
    image             = try values.decodeIfPresent(Image.self   , forKey: .image             )
 
  }

  init() {

  }

}


struct Image: Codable {

  var createdAt : String? = nil
  var alt       : String? = nil
  var width     : Int?    = nil
  var height    : Int?    = nil
  var src       : String? = nil

  enum CodingKeys: String, CodingKey {

    case createdAt = "created_at"
    case alt       = "alt"
    case width     = "width"
    case height    = "height"
    case src       = "src"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    createdAt = try values.decodeIfPresent(String.self , forKey: .createdAt )
    alt       = try values.decodeIfPresent(String.self , forKey: .alt       )
    width     = try values.decodeIfPresent(Int.self    , forKey: .width     )
    height    = try values.decodeIfPresent(Int.self    , forKey: .height    )
    src       = try values.decodeIfPresent(String.self , forKey: .src       )
 
  }

  init() {

  }

}

struct Rules: Codable {

  var column    : String? = nil
  var relation  : String? = nil
  var condition : String? = nil

  enum CodingKeys: String, CodingKey {

    case column    = "column"
    case relation  = "relation"
    case condition = "condition"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    column    = try values.decodeIfPresent(String.self , forKey: .column    )
    relation  = try values.decodeIfPresent(String.self , forKey: .relation  )
    condition = try values.decodeIfPresent(String.self , forKey: .condition )
 
  }

  init() {

  }

}
