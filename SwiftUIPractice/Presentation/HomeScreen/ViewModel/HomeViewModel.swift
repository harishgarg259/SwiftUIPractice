//
//  HomeViewModel.swift
//  Yappetizer
//
//  Created by Harish Garg on 11/06/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var productListArray: [ProductListModel] = []
    @Published var errorMessage = ""
    @Published var isLoading = false
    
    init() {
        //Intially load from local
        localProductList()
        if self.productListArray.isEmpty{
            //Load from api
            self.productList(searchText: "")
        }
    }
    
    func productList(searchText: String) {
        
        isLoading = true
        let parameters = ["page":1, "per_page": 20,"consumer_key":AppConstants.Consumer_Key, "consumer_secret": AppConstants.Consumer_Secret,"search":searchText] as [String : Any]
        let rest = RestManager<[ProductListModel]>()
        rest.makeRequest(request : WebAPI().productRequest(params : parameters, type: .productList)!) { (result) in
            switch result {
            case .success(let response):
                
                
                debugPrint(response)
                self.productListArray = response
                self.isLoading = false
                self.errorMessage  = ""
                
                if searchText.isEmpty{
                    self.saveLocalCache(response: response)
                }
                
            case .failure(let error):
                debugPrint(error.description)
                self.productListArray = []
                self.isLoading = false
                self.errorMessage  = "Server Error"
            }
        }
    }
    
    func saveLocalCache(response: [ProductListModel]) {
        let storage = PawStorageManager.PawStorageFile.productList
        PawStorageManager.shared.store(response, to: .caches, as: storage)
    }
    
    func localProductList() {
        let storage = PawStorageManager.PawStorageFile.productList
        let response = PawStorageManager.shared.retrieve(storage, from: .caches, as: [ProductListModel].self)
        self.productListArray = response ?? []
    }
}
