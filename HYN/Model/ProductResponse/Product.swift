
import Foundation

struct Product: Codable {

  var id                : Int?        = nil
  var title             : String?     = nil
  var bodyHtml          : String?     = nil
  var vendor            : String?     = nil
  var productType       : String?     = nil
  var createdAt         : String?     = nil
  var handle            : String?     = nil
  var updatedAt         : String?     = nil
  var publishedAt       : String?     = nil
  var templateSuffix    : String?     = nil
  var status            : String?     = nil
  var publishedScope    : String?     = nil
  var tags              : String?     = nil
  var adminGraphqlApiId : String?     = nil
  var variants          : [Variants]? = []
  var options           : [Options]?  = []
  var images            : [Images]?   = []
  var image             : ImageH?      = ImageH()

  enum CodingKeys: String, CodingKey {

    case id                = "id"
    case title             = "title"
    case bodyHtml          = "body_html"
    case vendor            = "vendor"
    case productType       = "product_type"
    case createdAt         = "created_at"
    case handle            = "handle"
    case updatedAt         = "updated_at"
    case publishedAt       = "published_at"
    case templateSuffix    = "template_suffix"
    case status            = "status"
    case publishedScope    = "published_scope"
    case tags              = "tags"
    case adminGraphqlApiId = "admin_graphql_api_id"
    case variants          = "variants"
    case options           = "options"
    case images            = "images"
    case image             = "image"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id                = try values.decodeIfPresent(Int.self        , forKey: .id                )
    title             = try values.decodeIfPresent(String.self     , forKey: .title             )
    bodyHtml          = try values.decodeIfPresent(String.self     , forKey: .bodyHtml          )
    vendor            = try values.decodeIfPresent(String.self     , forKey: .vendor            )
    productType       = try values.decodeIfPresent(String.self     , forKey: .productType       )
    createdAt         = try values.decodeIfPresent(String.self     , forKey: .createdAt         )
    handle            = try values.decodeIfPresent(String.self     , forKey: .handle            )
    updatedAt         = try values.decodeIfPresent(String.self     , forKey: .updatedAt         )
    publishedAt       = try values.decodeIfPresent(String.self     , forKey: .publishedAt       )
    templateSuffix    = try values.decodeIfPresent(String.self     , forKey: .templateSuffix    )
    status            = try values.decodeIfPresent(String.self     , forKey: .status            )
    publishedScope    = try values.decodeIfPresent(String.self     , forKey: .publishedScope    )
    tags              = try values.decodeIfPresent(String.self     , forKey: .tags              )
    adminGraphqlApiId = try values.decodeIfPresent(String.self     , forKey: .adminGraphqlApiId )
    variants          = try values.decodeIfPresent([Variants].self , forKey: .variants          )
    options           = try values.decodeIfPresent([Options].self  , forKey: .options           )
    images            = try values.decodeIfPresent([Images].self   , forKey: .images            )
    image             = try values.decodeIfPresent(ImageH.self      , forKey: .image             )
 
  }

  init() {

  }

}
