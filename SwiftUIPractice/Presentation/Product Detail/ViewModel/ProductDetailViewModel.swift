//
//  ProductDetailViewModel.swift
//  Yappetizer
//
//  Created by Harish Garg on 12/06/24.
//

import Foundation

class ProductDetailViewModel: ObservableObject {
    
    @Published var product: ProductListModel?
    @Published var variations: [VariationModel] = [VariationModel]()
    @Published var selectedSizeIndex = 0

    func productVariations() {
                
        let specialGETParams = "/\(product?.id ?? 0)/variations?consumer_key=\(AppConstants.Consumer_Key)&consumer_secret=\(AppConstants.Consumer_Secret)&_fields=\(AppConstants.VariationsFields)"

        
        let rest = RestManager<[VariationModel]>()
        rest.makeRequest(request : WebAPI().productRequest(params : [:], type: .variationDetail,specialGETParams: specialGETParams)!) { (result) in
            switch result {
            case .success(let response):
                debugPrint(response)
                self.variations = response
            case .failure(let error):
                debugPrint(error.description)
            }
        }
    }
    
    func prepareVariationArray(){
        
    }
}
