
import Foundation

struct ProductResponse: Codable {

  var product : Product? = Product()

  enum CodingKeys: String, CodingKey {

    case product = "product"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    product = try values.decodeIfPresent(Product.self , forKey: .product )
 
  }

  init() {

  }

}