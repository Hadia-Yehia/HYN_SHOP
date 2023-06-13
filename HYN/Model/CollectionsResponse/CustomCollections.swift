//
//  CustomCollections.swift
//  HYN
//
//  Created by Nada youssef on 11/06/2023.
//

import Foundation
struct CustomCollectionsResult: Codable {

  var customCollections : [CustomCollections]? = []

  enum CodingKeys: String, CodingKey {

    case customCollections = "custom_collections"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    customCollections = try values.decodeIfPresent([CustomCollections].self , forKey: .customCollections )
 
  }

  init() {

  }

}
struct CustomCollections: Codable {

  var id                : Int?    = nil
  var handle            : String? = nil
  var title             : String? = nil
  var updatedAt         : String? = nil
  var bodyHtml          : String? = nil
  var publishedAt       : String? = nil
  var sortOrder         : String? = nil
  var templateSuffix    : String? = nil
  var publishedScope    : String? = nil
  var adminGraphqlApiId : String? = nil
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
    case publishedScope    = "published_scope"
    case adminGraphqlApiId = "admin_graphql_api_id"
      case image             = "image"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id                = try values.decodeIfPresent(Int.self    , forKey: .id                )
    handle            = try values.decodeIfPresent(String.self , forKey: .handle            )
    title             = try values.decodeIfPresent(String.self , forKey: .title             )
    updatedAt         = try values.decodeIfPresent(String.self , forKey: .updatedAt         )
    bodyHtml          = try values.decodeIfPresent(String.self , forKey: .bodyHtml          )
    publishedAt       = try values.decodeIfPresent(String.self , forKey: .publishedAt       )
    sortOrder         = try values.decodeIfPresent(String.self , forKey: .sortOrder         )
    templateSuffix    = try values.decodeIfPresent(String.self , forKey: .templateSuffix    )
    publishedScope    = try values.decodeIfPresent(String.self , forKey: .publishedScope    )
    adminGraphqlApiId = try values.decodeIfPresent(String.self , forKey: .adminGraphqlApiId )
    image             = try values.decodeIfPresent(Image.self   , forKey: .image             )
 
  }

  init() {

  }

}
