//
//  Cart.swift
//  Yappetizer
//
//  Created by Harish Garg on 2024-07-06.
//

import Foundation

struct ProductCartItems {
    var id: Int
    var price: String
    var variationID: Int // Assuming size is a string for simplicity
    var quantity: Int
    var product: CartProduct
}
