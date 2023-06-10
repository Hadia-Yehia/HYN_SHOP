
import Foundation

struct Variants: Codable {

  var id                   : Int?    = nil
  var productId            : Int?    = nil
  var title                : String? = nil
  var price                : String? = nil
  var sku                  : String? = nil
  var position             : Int?    = nil
  var inventoryPolicy      : String? = nil
  var compareAtPrice       : String? = nil
  var fulfillmentService   : String? = nil
  var inventoryManagement  : String? = nil
  var option1              : String? = nil
  var option2              : String? = nil
  var option3              : String? = nil
  var createdAt            : String? = nil
  var updatedAt            : String? = nil
  var taxable              : Bool?   = nil
  var barcode              : String? = nil
  var grams                : Int?    = nil
  var imageId              : String? = nil
  var weight               : Int?    = nil
  var weightUnit           : String? = nil
  var inventoryItemId      : Int?    = nil
  var inventoryQuantity    : Int?    = nil
  var oldInventoryQuantity : Int?    = nil
  var requiresShipping     : Bool?   = nil
  var adminGraphqlApiId    : String? = nil

  enum CodingKeys: String, CodingKey {

    case id                   = "id"
    case productId            = "product_id"
    case title                = "title"
    case price                = "price"
    case sku                  = "sku"
    case position             = "position"
    case inventoryPolicy      = "inventory_policy"
    case compareAtPrice       = "compare_at_price"
    case fulfillmentService   = "fulfillment_service"
    case inventoryManagement  = "inventory_management"
    case option1              = "option1"
    case option2              = "option2"
    case option3              = "option3"
    case createdAt            = "created_at"
    case updatedAt            = "updated_at"
    case taxable              = "taxable"
    case barcode              = "barcode"
    case grams                = "grams"
    case imageId              = "image_id"
    case weight               = "weight"
    case weightUnit           = "weight_unit"
    case inventoryItemId      = "inventory_item_id"
    case inventoryQuantity    = "inventory_quantity"
    case oldInventoryQuantity = "old_inventory_quantity"
    case requiresShipping     = "requires_shipping"
    case adminGraphqlApiId    = "admin_graphql_api_id"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id                   = try values.decodeIfPresent(Int.self    , forKey: .id                   )
    productId            = try values.decodeIfPresent(Int.self    , forKey: .productId            )
    title                = try values.decodeIfPresent(String.self , forKey: .title                )
    price                = try values.decodeIfPresent(String.self , forKey: .price                )
    sku                  = try values.decodeIfPresent(String.self , forKey: .sku                  )
    position             = try values.decodeIfPresent(Int.self    , forKey: .position             )
    inventoryPolicy      = try values.decodeIfPresent(String.self , forKey: .inventoryPolicy      )
    compareAtPrice       = try values.decodeIfPresent(String.self , forKey: .compareAtPrice       )
    fulfillmentService   = try values.decodeIfPresent(String.self , forKey: .fulfillmentService   )
    inventoryManagement  = try values.decodeIfPresent(String.self , forKey: .inventoryManagement  )
    option1              = try values.decodeIfPresent(String.self , forKey: .option1              )
    option2              = try values.decodeIfPresent(String.self , forKey: .option2              )
    option3              = try values.decodeIfPresent(String.self , forKey: .option3              )
    createdAt            = try values.decodeIfPresent(String.self , forKey: .createdAt            )
    updatedAt            = try values.decodeIfPresent(String.self , forKey: .updatedAt            )
    taxable              = try values.decodeIfPresent(Bool.self   , forKey: .taxable              )
    barcode              = try values.decodeIfPresent(String.self , forKey: .barcode              )
    grams                = try values.decodeIfPresent(Int.self    , forKey: .grams                )
    imageId              = try values.decodeIfPresent(String.self , forKey: .imageId              )
    weight               = try values.decodeIfPresent(Int.self    , forKey: .weight               )
    weightUnit           = try values.decodeIfPresent(String.self , forKey: .weightUnit           )
    inventoryItemId      = try values.decodeIfPresent(Int.self    , forKey: .inventoryItemId      )
    inventoryQuantity    = try values.decodeIfPresent(Int.self    , forKey: .inventoryQuantity    )
    oldInventoryQuantity = try values.decodeIfPresent(Int.self    , forKey: .oldInventoryQuantity )
    requiresShipping     = try values.decodeIfPresent(Bool.self   , forKey: .requiresShipping     )
    adminGraphqlApiId    = try values.decodeIfPresent(String.self , forKey: .adminGraphqlApiId    )
 
  }

  init() {

  }

}