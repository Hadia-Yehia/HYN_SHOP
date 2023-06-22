
import Foundation

struct LineItems: Codable {

  var title    : String
  var price    : String
  var quantity : Int
    init(title: String, price: String, quantity: Int) {
        self.title = title
        self.price = price
        self.quantity = quantity
    }
}
