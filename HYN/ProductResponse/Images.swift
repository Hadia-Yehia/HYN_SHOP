
import Foundation

struct Images: Codable {

  var id                : Int?      = nil
  var productId         : Int?      = nil
  var position          : Int?      = nil
  var createdAt         : String?   = nil
  var updatedAt         : String?   = nil
  var alt               : String?   = nil
  var width             : Int?      = nil
  var height            : Int?      = nil
  var src               : String?   = nil
  var variantIds        : [String]? = []
  var adminGraphqlApiId : String?   = nil

  enum CodingKeys: String, CodingKey {

    case id                = "id"
    case productId         = "product_id"
    case position          = "position"
    case createdAt         = "created_at"
    case updatedAt         = "updated_at"
    case alt               = "alt"
    case width             = "width"
    case height            = "height"
    case src               = "src"
    case variantIds        = "variant_ids"
    case adminGraphqlApiId = "admin_graphql_api_id"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id                = try values.decodeIfPresent(Int.self      , forKey: .id                )
    productId         = try values.decodeIfPresent(Int.self      , forKey: .productId         )
    position          = try values.decodeIfPresent(Int.self      , forKey: .position          )
    createdAt         = try values.decodeIfPresent(String.self   , forKey: .createdAt         )
    updatedAt         = try values.decodeIfPresent(String.self   , forKey: .updatedAt         )
    alt               = try values.decodeIfPresent(String.self   , forKey: .alt               )
    width             = try values.decodeIfPresent(Int.self      , forKey: .width             )
    height            = try values.decodeIfPresent(Int.self      , forKey: .height            )
    src               = try values.decodeIfPresent(String.self   , forKey: .src               )
    variantIds        = try values.decodeIfPresent([String].self , forKey: .variantIds        )
    adminGraphqlApiId = try values.decodeIfPresent(String.self   , forKey: .adminGraphqlApiId )
 
  }

  init() {

  }

}