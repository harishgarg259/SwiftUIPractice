//
//  OrderListViewModel.swift
//  Yappetizer
//
//  Created by Harish Garg on 22/06/24.
//

import Foundation

@MainActor
class OrderListViewModel: ObservableObject {
    
    @Published var orderList: [OrderList] = []
    
    init() {
        
        //Offline loading of orders
        localOrdersList()
        
        //call api for latest orders
        getOrders()
    }
    
    func getOrders() {
        
        let specialGETParams = "?customer=\(UserDefaultsManager.userID ?? 0)&consumer_key=\(AppConstants.Consumer_Key)&consumer_secret=\(AppConstants.Consumer_Secret)&\(String.random())"
        let rest = RestManager<[OrderList]>()
        rest.makeRequest(request : WebAPI().productRequest(params : [:], type: .orderList,specialGETParams: specialGETParams)!) { (result) in
            switch result {
            case .success(let response):
                debugPrint(response)
                self.orderList = response
                self.saveLocalCache(response: response)
            case .failure(let error):
                debugPrint(error.description)
            }
        }
    }
    
    func saveLocalCache(response: [OrderList]) {
        let userID = "\(UserDefaultsManager.userID ?? 0)"
        let storage = PawStorageManager.PawStorageFile.orderList(userID)
        PawStorageManager.shared.store(response, to: .caches, as: storage)
    }
    
    func localOrdersList() {
        let userID = "\(UserDefaultsManager.userID ?? 0)"
        let storage = PawStorageManager.PawStorageFile.orderList(userID)
        let response = PawStorageManager.shared.retrieve(storage, from: .caches, as: [OrderList].self)
        self.orderList = response ?? []
    }

}
