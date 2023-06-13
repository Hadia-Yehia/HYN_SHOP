
import Foundation

struct DraftOrder: Codable {

  var lineItems                 : [LineItems]?     = []


  enum CodingKeys: String, CodingKey {

    case lineItems                 = "line_items"
 
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    lineItems                 = try values.decodeIfPresent([LineItems].self     , forKey: .lineItems                 )
  }

  init() {

  }

}
