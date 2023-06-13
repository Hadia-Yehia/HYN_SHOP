
import Foundation

struct DraftOrderRequest: Codable {

  var draft_order : DraftOrder
    init(draft_order: DraftOrder) {
        self.draft_order = draft_order
    }

}
