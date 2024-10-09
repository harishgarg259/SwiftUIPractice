//
//  CouponViewModel.swift
//  Yappetizer
//
//  Created by Harish Garg on 2024-10-01.
//

import Foundation

class CouponViewModel: ObservableObject {
    
    @Published var couponList: [CouponItem] = []
    @Published var couponCode: String = ""

    init() {
        //Offline loading of orders
        localCouponList()
        
        //call api for latest orders
        getCoupons()
    }
    
    func getCoupons() {
        
        let parameters = ["consumer_key":AppConstants.Consumer_Key, "consumer_secret": AppConstants.Consumer_Secret] as [String : Any]

        let rest = RestManager<[CouponItem]>()
        rest.makeRequest(request : WebAPI().productRequest(params : parameters, type: .couponList)!) { (result) in
            switch result {
            case .success(let response):
                debugPrint(response)
                self.couponList = response
                self.saveLocalCache(response: response)
            case .failure(let error):
                debugPrint(error.description)
            }
        }
    }
    
    func saveLocalCache(response: [CouponItem]) {
        let userID = "\(UserDefaultsManager.userID ?? 0)"
        let storage = PawStorageManager.PawStorageFile.orderList(userID)
        PawStorageManager.shared.store(response, to: .caches, as: storage)
    }
    
    func localCouponList() {
        let userID = "\(UserDefaultsManager.userID ?? 0)"
        let storage = PawStorageManager.PawStorageFile.orderList(userID)
        let response = PawStorageManager.shared.retrieve(storage, from: .caches, as: [CouponItem].self)
        self.couponList = response ?? []
    }
}
