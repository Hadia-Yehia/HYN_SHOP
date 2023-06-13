
import Foundation

struct DraftOrderResponse: Codable {

  var draftOrder : DraftOrderResponsed? = DraftOrderResponsed()

  enum CodingKeys: String, CodingKey {

    case draftOrder = "draft_order"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    draftOrder = try values.decodeIfPresent(DraftOrderResponsed.self , forKey: .draftOrder )
 
  }

  init() {

  }

}
