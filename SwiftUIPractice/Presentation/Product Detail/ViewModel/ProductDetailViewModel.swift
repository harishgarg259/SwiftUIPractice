//
//  ProductDetailViewModel.swift
//  Yappetizer
//
//  Created by Harish Garg on 12/06/24.
//

import Foundation

class ProductDetailViewModel: ObservableObject {
    
    @Published var product: ProductListModel?
    var variations: [VariationModel] = [VariationModel]()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var productPrice: String?
    @Published var images : [ProductImages]?
    @Published var stock_quantity : Int?
    @Published var sale_price : String?
    @Published var on_sale : Bool?
    @Published var in_stock : Bool?
    @Published var regular_price : String?
    @Published var encodedDescription: String?
    @Published var quantity = 1
    @Published var name : String?
    @Published var attributes : [Attributes]?
    @Published var categories : [Categories]?
    @Published var description: String?

    var variationID: Int?

    var cartProduct: CartProduct = CartProduct(){
        didSet {
            cartProduct.id = product?.id
            cartProduct.price = productPrice
            cartProduct.images = images
            cartProduct.regular_price = regular_price
            cartProduct.sale_price = sale_price
            cartProduct.stock_quantity = quantity
            cartProduct.in_stock = in_stock
            cartProduct.on_sale = on_sale
            cartProduct.variationID = variationID
        }
    }
    
    var selectedSizeIndex = 0
    {
        didSet {
            self.prepareVariationArray(index: selectedSizeIndex,isVariationExist: !self.variations.isEmpty)
        }
    }
    
    
    func productVariations() {
        isLoading = true
        self.errorMessage = nil
        
        let specialGETParams = "/\(product?.id ?? 0)/variations?consumer_key=\(AppConstants.Consumer_Key)&consumer_secret=\(AppConstants.Consumer_Secret)&_fields=\(AppConstants.VariationsFields)"
        
        let rest = RestManager<[VariationModel]>()
        rest.makeRequest(request : WebAPI().productRequest(params : [:], type: .variationDetail,specialGETParams: specialGETParams)!) { (result) in
            switch result {
            case .success(let response):
                debugPrint(response)
                self.variations = response
                self.isLoading = false
                self.prepareVariationArray(index: 0,isVariationExist: !self.variations.isEmpty)
            case .failure(let error):
                debugPrint(error.description)
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func prepareVariationArray(index: Int, isVariationExist: Bool){
        
        name = product?.name
        attributes = product?.attributes
        categories = product?.categories
        encodedDescription = product?.description
        
        if !isVariationExist{
            productPrice = product?.price
            images = product?.images
            regular_price = product?.regular_price
            sale_price = product?.sale_price
            stock_quantity = product?.stock_quantity
            in_stock = product?.in_stock
            on_sale = product?.on_sale
            variationID = product?.id
        }else{
            productPrice = self.variations[index].price
            if let image = self.variations[index].image{
                images = [image]
            }
            regular_price = self.variations[index].regular_price
            sale_price = self.variations[index].sale_price
            stock_quantity = self.variations[index].stock_quantity
            in_stock = self.variations[index].in_stock
            on_sale = self.variations[index].on_sale
            variationID = self.variations[index].id
        }
//        productDetail.name = product?.name
//        productDetail.date_created = product?.date_created
//        productDetail.featured = product?.featured
//        productDetail.description = product?.description
//        productDetail.attributes = product?.attributes
//        productDetail.categories = product?.categories
//        productDetail.price_html = product?.price
//        
//        productDetail.images = product?.images
//        productDetail.regular_price = product?.regular_price
//        productDetail.price = product?.price
//        productDetail.sale_price = product?.sale_price
//        productDetail.stock_quantity = product?.stock_quantity
//        productDetail.in_stock = product?.in_stock
//        productDetail.on_sale = product?.on_sale
//        
//        
//        if !isVariationExist{
//            var variation = VariationModel()
//            var variationAttributes = VariationAttributes()
//            variationAttributes.option = ""
//            variation.attributes = [variationAttributes]
//            productDetail.variations = [variation]
//            productDetail.variationID = 0
//        }else{
//            if let images = self.variations[index].image{
//                productDetail.images = [images]
//            }
//            productDetail.regular_price = self.variations[index].regular_price
//            productDetail.price = self.variations[index].price
//            productDetail.sale_price = self.variations[index].sale_price
//            productDetail.stock_quantity = self.variations[index].stock_quantity
//            productDetail.in_stock = self.variations[index].in_stock
//            productDetail.on_sale = self.variations[index].on_sale
//            productDetail.variations = self.variations
//            productDetail.variationID = self.variations[index].id
//        }
//        objectWillChange.send()
    }
}
