//
//  CartViewModel.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-03.
//

import SwiftUI

class  CartViewModel: ObservableObject {
    @Published var cartProduct: [ProductListModel] = []
//    @Published var cartProductDic: [Product: Int] = [:]
    @Published var totalPrice: Double = 0
    @Published var showShowcaseSheet: Bool = false
    
    
    
    init() {
        
    }
    
    
    
    /// adding a product with the quantity on our cart
    /// - Parameters:
    ///   - addedProduct: product we want to add
    ///   - quantity: quantity of product we want to add
    func addToCart(addedProduct: ProductListModel?, quantity: Int){
        
        guard let product = addedProduct else { return }
        cartProduct.append(product)
        
//        let products = cartProductDic.map({$0.key})
        // if we don't have any product we just create it with our quantity and leave the func
//        if products.isEmpty {
//            withAnimation{
//                cartProductDic[addedProduct] = quantity
//            }
//            return
//        }
//        for product in products {
//            // if we already have the product we check our product and add the quantity
//            if addedProduct.id == product.id {
//                withAnimation{
//                    cartProductDic[product]! += quantity
//                }
//            } else {
//                // if we have products but dont have this one, we create it with the quantity
//                if !products.contains(where: {$0.id == addedProduct.id}){
//                    withAnimation{
//                        cartProductDic[addedProduct] = quantity
//                    }
//                }
//            }
//        }
    }
    func changeQuantity(product: ProductListModel,quantity: Int){
//        cartProductDic[product] = quantity
    }
    
    func calculateTotalPrice(){
//        var totalprice: Double = 0
//        for (product,quantity) in cartProduct {
//            totalprice += product.price * Double(quantity)
//        }
//        withAnimation{
//            totalPrice = totalprice
//        }
    }
    func removeFromCart(toRemove: ProductListModel){
        if let index = cartProduct.firstIndex(where: { $0.id == toRemove.id }) {
            cartProduct.remove(at: index)
        }
    }
}
