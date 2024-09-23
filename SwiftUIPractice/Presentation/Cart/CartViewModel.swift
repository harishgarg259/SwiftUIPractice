//
//  CartViewModel.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-03.
//

import SwiftUI

class  CartViewModel: ObservableObject {
    
    @Published var cartArray: [ProductCartItems] = []
    
    @Published var totalPrice: Double = 0
    @Published var showShowcaseSheet: Bool = false
    
    init() {
        
    }
    
    /// adding a product with the quantity on our cart
    /// - Parameters:
    ///   - addedProduct: product we want to add
    ///   - quantity: quantity of product we want to add
    func addProduct(product: CartProduct, quantity: Int) {
        let sameProducts = cartArray.filter({$0.id == product.id})
        if sameProducts.isEmpty{
            let cartItem = ProductCartItems(id: product.id ?? 0, price: product.price ?? "", variationID: product.variationID ?? 0, quantity: quantity, product: product)
            cartArray.append(cartItem)
        }else{
            let sameVariation = sameProducts.filter({$0.variationID == product.variationID})
            if !sameVariation.isEmpty{
                let updatedQuantity =  (sameVariation[0].quantity) + quantity
                cartArray.removeAll(where:  {$0.id == product.id && $0.variationID == product.variationID} )
                let cartItem = ProductCartItems(id: product.id ?? 0, price: product.price ?? "", variationID: product.variationID ?? 0, quantity: updatedQuantity, product: product)
                cartArray.append(cartItem)
            }else{
                let cartItem = ProductCartItems(id: product.id ?? 0, price: product.price ?? "", variationID: product.variationID ?? 0, quantity: quantity, product: product)
                cartArray.append(cartItem)
            }
        }
    }
    
    func deleteProduct(product: CartProduct) {
        
    }
    
    func editProductQuantity(product: CartProduct, newQuantity: Int) {
        
    }
}
