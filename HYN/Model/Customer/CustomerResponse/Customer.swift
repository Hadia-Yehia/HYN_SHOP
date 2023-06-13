
import Foundation
struct CustomerResponse : Codable{
    var customer : CustomerResponsed
    init(customer: CustomerResponsed) {
        self.customer = customer
    }
}

struct CustomerResponsed: Codable {

  var id                        : Int?                   = nil
  var email                     : String?                = nil
  var acceptsMarketing          : Bool?                  = nil
  var createdAt                 : String?                = nil
  var updatedAt                 : String?                = nil
  var firstName                 : String?                = nil
  var lastName                  : String?                = nil
  var ordersCount               : Int?                   = nil
  var state                     : String?                = nil
  var totalSpent                : String?                = nil
  var lastOrderId               : String?                = nil
  var note                      : String?                = nil
  var verifiedEmail             : Bool?                  = nil
  var multipassIdentifier       : String?                = nil
  var taxExempt                 : Bool?                  = nil
  var tags                      : String?                = nil
  var lastOrderName             : String?                = nil
  var currency                  : String?                = nil
  var phone                     : String?                = nil
  var acceptsMarketingUpdatedAt : String?                = nil
  var marketingOptInLevel       : String?                = nil
  var taxExemptions             : [String]?              = []


  enum CodingKeys: String, CodingKey {

    case id                        = "id"
    case email                     = "email"
    case acceptsMarketing          = "accepts_marketing"
    case createdAt                 = "created_at"
    case updatedAt                 = "updated_at"
    case firstName                 = "first_name"
    case lastName                  = "last_name"
    case ordersCount               = "orders_count"
    case state                     = "state"
    case totalSpent                = "total_spent"
    case lastOrderId               = "last_order_id"
    case note                      = "note"
    case verifiedEmail             = "verified_email"
    case multipassIdentifier       = "multipass_identifier"
    case taxExempt                 = "tax_exempt"
    case tags                      = "tags"
    case lastOrderName             = "last_order_name"
    case currency                  = "currency"
    case phone                     = "phone"
    case acceptsMarketingUpdatedAt = "accepts_marketing_updated_at"
    case marketingOptInLevel       = "marketing_opt_in_level"
    case taxExemptions             = "tax_exemptions"
  
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id                        = try values.decodeIfPresent(Int.self                   , forKey: .id                        )
    email                     = try values.decodeIfPresent(String.self                , forKey: .email                     )
    acceptsMarketing          = try values.decodeIfPresent(Bool.self                  , forKey: .acceptsMarketing          )
    createdAt                 = try values.decodeIfPresent(String.self                , forKey: .createdAt                 )
    updatedAt                 = try values.decodeIfPresent(String.self                , forKey: .updatedAt                 )
    firstName                 = try values.decodeIfPresent(String.self                , forKey: .firstName                 )
    lastName                  = try values.decodeIfPresent(String.self                , forKey: .lastName                  )
    ordersCount               = try values.decodeIfPresent(Int.self                   , forKey: .ordersCount               )
    state                     = try values.decodeIfPresent(String.self                , forKey: .state                     )
    totalSpent                = try values.decodeIfPresent(String.self                , forKey: .totalSpent                )
    lastOrderId               = try values.decodeIfPresent(String.self                , forKey: .lastOrderId               )
    note                      = try values.decodeIfPresent(String.self                , forKey: .note                      )
    verifiedEmail             = try values.decodeIfPresent(Bool.self                  , forKey: .verifiedEmail             )
    multipassIdentifier       = try values.decodeIfPresent(String.self                , forKey: .multipassIdentifier       )
    taxExempt                 = try values.decodeIfPresent(Bool.self                  , forKey: .taxExempt                 )
    tags                      = try values.decodeIfPresent(String.self                , forKey: .tags                      )
    lastOrderName             = try values.decodeIfPresent(String.self                , forKey: .lastOrderName             )
    currency                  = try values.decodeIfPresent(String.self                , forKey: .currency                  )
    phone                     = try values.decodeIfPresent(String.self                , forKey: .phone                     )
    acceptsMarketingUpdatedAt = try values.decodeIfPresent(String.self                , forKey: .acceptsMarketingUpdatedAt )
    marketingOptInLevel       = try values.decodeIfPresent(String.self                , forKey: .marketingOptInLevel       )
    taxExemptions             = try values.decodeIfPresent([String].self              , forKey: .taxExemptions             )

 
  }

  init() {

  }

}
