
import Foundation

struct Options: Codable {

  var id        : Int?      = nil
  var productId : Int?      = nil
  var name      : String?   = nil
  var position  : Int?      = nil
  var valuesArr    : [String]? = []

  enum CodingKeys: String, CodingKey {

    case id        = "id"
    case productId = "product_id"
    case name      = "name"
    case position  = "position"
    case valuesArr   = "values"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id        = try values.decodeIfPresent(Int.self      , forKey: .id        )
    productId = try values.decodeIfPresent(Int.self      , forKey: .productId )
    name      = try values.decodeIfPresent(String.self   , forKey: .name      )
    position  = try values.decodeIfPresent(Int.self      , forKey: .position  )
    valuesArr    = try values.decodeIfPresent([String].self , forKey: .valuesArr    )
 
  }

  init() {

  }

}
