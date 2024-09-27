//
//  CartViewModel.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-03.
//

import SwiftUI

class  CartViewModel: ObservableObject {
    
    // Shipping cost
    @Published var shipping: Double = 5.99
    @Published var totalPrice: Double = 0
    @Published var showShowcaseSheet: Bool = false
    @Published var cartArray: [ProductCartItems] = []{
        didSet{
            self.saveLocalCache(response: cartArray)
        }
    }
    
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
    
    func deleteProduct(product: ProductCartItems) {
        
    }
    
    func editProductQuantity(product: ProductCartItems, newQuantity: Int) {
        
    }
    
    // Calculate subtotal
    var subtotal: Double {
        cartArray.reduce(0) { $0 + ((Double($1.price) ?? 0.0) * Double($1.quantity)) }
    }
    
    // Calculate grand total (for example purposes, shipping is free)
    
    var total: Double {
        return subtotal + shipping
    }
    
    // Increment quantity
    func incrementQuantity(for item: ProductCartItems) {
        if let index = cartArray.firstIndex(where: { $0.id == item.id }) {
            cartArray[index].quantity += 1
        }
    }
    
    // Decrement quantity
    func decrementQuantity(for item: ProductCartItems) {
        if let index = cartArray.firstIndex(where: { $0.id == item.id }), cartArray[index].quantity > 1 {
            cartArray[index].quantity -= 1
        }
    }
    
    // Remove item
    func removeItem(_ item: ProductCartItems) {
        cartArray.removeAll { $0.id == item.id }
    }
    
    func saveLocalCache(response: [ProductCartItems]) {
        let userID = "\(UserDefaultsManager.userID ?? 0)"
        let storage = PawStorageManager.PawStorageFile.cartList(userID)
        PawStorageManager.shared.store(response, to: .caches, as: storage)
    }
    
    func getCartDetail(){
        let userID = "\(UserDefaultsManager.userID ?? 0)"
        let storage = PawStorageManager.PawStorageFile.cartList(userID)
        let response = PawStorageManager.shared.retrieve(storage, from: .caches, as: [ProductCartItems].self)
        if ((response?.isEmpty) != nil){
            cartArray.removeAll()
            cartArray = response ?? []
        }
    }
}
