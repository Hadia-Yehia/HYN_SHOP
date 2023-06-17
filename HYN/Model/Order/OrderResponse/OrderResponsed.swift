//
//  OrderResponsed.swift
//  HYN
//
//  Created by Nada youssef on 16/06/2023.
//

import Foundation
struct OrderResponsed : Codable {

  var id                     : Int?                    = nil
//  var note                   : String?                 = nil
//  var email                  : String?                 = nil
//  var taxesIncluded          : Bool?                   = nil
//  var currency               : String?                 = nil
//  var invoiceSentAt          : String?                 = nil
//  var createdAt              : String?                 = nil
//  var updatedAt              : String?                 = nil
//  var taxExempt              : Bool?                   = nil
//  var completedAt            : String?                 = nil
//  var name                   : String?                 = nil
//  var status                 : String?                 = nil
  var lineItems              : [LineItems]?            = []
//  var shippingAddress        : ShippingAddress?        = ShippingAddress()
//  var billingAddress         : BillingAddress?         = BillingAddress()
//  var invoiceUrl             : String?                 = nil
//  var appliedDiscount        : AppliedDiscount?        = AppliedDiscount()
//  var orderId                : String?                 = nil
//  var shippingLine           : String?                 = nil
//  var taxLines               : [String]?               = []
//  var tags                   : String?                 = nil
//  var noteAttributes         : [String]?               = []
//  var totalPrice             : String?                 = nil
//  var subtotalPrice          : String?                 = nil
//  var totalTax               : String?                 = nil
//  var presentmentCurrency    : String?                 = nil
//  var totalLineItemsPriceSet : TotalLineItemsPriceSet? = TotalLineItemsPriceSet()
//  var totalPriceSet          : TotalPriceSet?          = TotalPriceSet()
//  var subtotalPriceSet       : SubtotalPriceSet?       = SubtotalPriceSet()
//  var totalTaxSet            : TotalTaxSet?            = TotalTaxSet()
//  var totalDiscountsSet      : TotalDiscountsSet?      = TotalDiscountsSet()
//  var totalShippingPriceSet  : TotalShippingPriceSet?  = TotalShippingPriceSet()
//  var totalAdditionalFeesSet : String?                 = nil
//  var totalDutiesSet         : String?                 = nil
//  var paymentTerms           : String?                 = nil
//  var adminGraphqlApiId      : String?                 = nil
 

  enum CodingKeys: String, CodingKey {

    case id                     = "id"
//    case note                   = "note"
//    case email                  = "email"
//    case taxesIncluded          = "taxes_included"
//    case currency               = "currency"
//    case invoiceSentAt          = "invoice_sent_at"
//    case createdAt              = "created_at"
//    case updatedAt              = "updated_at"
//    case taxExempt              = "tax_exempt"
//    case completedAt            = "completed_at"
//    case name                   = "name"
//    case status                 = "status"
    case lineItems              = "line_items"
//    case shippingAddress        = "shipping_address"
//    case billingAddress         = "billing_address"
//    case invoiceUrl             = "invoice_url"
//    case appliedDiscount        = "applied_discount"
//    case orderId                = "order_id"
//    case shippingLine           = "shipping_line"
//    case taxLines               = "tax_lines"
//    case tags                   = "tags"
//    case noteAttributes         = "note_attributes"
//    case totalPrice             = "total_price"
//    case subtotalPrice          = "subtotal_price"
//    case totalTax               = "total_tax"
//    case presentmentCurrency    = "presentment_currency"
//    case totalLineItemsPriceSet = "total_line_items_price_set"
//    case totalPriceSet          = "total_price_set"
//    case subtotalPriceSet       = "subtotal_price_set"
//    case totalTaxSet            = "total_tax_set"
//    case totalDiscountsSet      = "total_discounts_set"
//    case totalShippingPriceSet  = "total_shipping_price_set"
//    case totalAdditionalFeesSet = "total_additional_fees_set"
//    case totalDutiesSet         = "total_duties_set"
//    case paymentTerms           = "payment_terms"
//    case adminGraphqlApiId      = "admin_graphql_api_id"
    
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id                     = try values.decodeIfPresent(Int.self                    , forKey: .id                     )
//    note                   = try values.decodeIfPresent(String.self                 , forKey: .note                   )
//    email                  = try values.decodeIfPresent(String.self                 , forKey: .email                  )
//    taxesIncluded          = try values.decodeIfPresent(Bool.self                   , forKey: .taxesIncluded          )
//    currency               = try values.decodeIfPresent(String.self                 , forKey: .currency               )
//    invoiceSentAt          = try values.decodeIfPresent(String.self                 , forKey: .invoiceSentAt          )
//    createdAt              = try values.decodeIfPresent(String.self                 , forKey: .createdAt              )
//    updatedAt              = try values.decodeIfPresent(String.self                 , forKey: .updatedAt              )
//    taxExempt              = try values.decodeIfPresent(Bool.self                   , forKey: .taxExempt              )
//    completedAt            = try values.decodeIfPresent(String.self                 , forKey: .completedAt            )
//    name                   = try values.decodeIfPresent(String.self                 , forKey: .name                   )
//    status                 = try values.decodeIfPresent(String.self                 , forKey: .status                 )
    lineItems              = try values.decodeIfPresent([LineItems].self            , forKey: .lineItems              )
//    shippingAddress        = try values.decodeIfPresent(ShippingAddress.self        , forKey: .shippingAddress        )
//    billingAddress         = try values.decodeIfPresent(BillingAddress.self         , forKey: .billingAddress         )
//    invoiceUrl             = try values.decodeIfPresent(String.self                 , forKey: .invoiceUrl             )
//    appliedDiscount        = try values.decodeIfPresent(AppliedDiscount.self        , forKey: .appliedDiscount        )
//    orderId                = try values.decodeIfPresent(String.self                 , forKey: .orderId                )
//    shippingLine           = try values.decodeIfPresent(String.self                 , forKey: .shippingLine           )
//    taxLines               = try values.decodeIfPresent([String].self               , forKey: .taxLines               )
//    tags                   = try values.decodeIfPresent(String.self                 , forKey: .tags                   )
//    noteAttributes         = try values.decodeIfPresent([String].self               , forKey: .noteAttributes         )
//    totalPrice             = try values.decodeIfPresent(String.self                 , forKey: .totalPrice             )
//    subtotalPrice          = try values.decodeIfPresent(String.self                 , forKey: .subtotalPrice          )
//    totalTax               = try values.decodeIfPresent(String.self                 , forKey: .totalTax               )
//    presentmentCurrency    = try values.decodeIfPresent(String.self                 , forKey: .presentmentCurrency    )
//    totalLineItemsPriceSet = try values.decodeIfPresent(TotalLineItemsPriceSet.self , forKey: .totalLineItemsPriceSet )
//    totalPriceSet          = try values.decodeIfPresent(TotalPriceSet.self          , forKey: .totalPriceSet          )
//    subtotalPriceSet       = try values.decodeIfPresent(SubtotalPriceSet.self       , forKey: .subtotalPriceSet       )
//    totalTaxSet            = try values.decodeIfPresent(TotalTaxSet.self            , forKey: .totalTaxSet            )
//    totalDiscountsSet      = try values.decodeIfPresent(TotalDiscountsSet.self      , forKey: .totalDiscountsSet      )
//    totalShippingPriceSet  = try values.decodeIfPresent(TotalShippingPriceSet.self  , forKey: .totalShippingPriceSet  )
//    totalAdditionalFeesSet = try values.decodeIfPresent(String.self                 , forKey: .totalAdditionalFeesSet )
//    totalDutiesSet         = try values.decodeIfPresent(String.self                 , forKey: .totalDutiesSet         )
//    paymentTerms           = try values.decodeIfPresent(String.self                 , forKey: .paymentTerms           )
//    adminGraphqlApiId      = try values.decodeIfPresent(String.self                 , forKey: .adminGraphqlApiId      )

 
  }

  init() {

  }

}
