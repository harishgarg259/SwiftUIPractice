//
//  BlogListViewModel.swift
//  Yappetizer
//
//  Created by Harish Garg on 25/06/24.
//

import Foundation

@MainActor
class BlogListViewModel: ObservableObject {
    
    @Published var blogList: [BlogBaseModel] = []
    
    init() {
        
        //Offline loading of orders
        localBlogsList()
        
        //call api for latest orders
        getBlogs()
    }
    
    func getBlogs() {
        
        let rest = RestManager<[BlogBaseModel]>()
        rest.makeRequest(request : WebAPI().productRequest(params : [:], type: .blogList)!) { (result) in
            switch result {
            case .success(let response):
                debugPrint(response)
                self.blogList = response
                self.saveLocalCache(response: response)
            case .failure(let error):
                debugPrint(error.description)
            }
        }
    }
    
    func saveLocalCache(response: [BlogBaseModel]) {
        let userID = "\(UserDefaultsManager.userID ?? 0)"
        let storage = PawStorageManager.PawStorageFile.orderList(userID)
        PawStorageManager.shared.store(response, to: .caches, as: storage)
    }
    
    func localBlogsList() {
        let userID = "\(UserDefaultsManager.userID ?? 0)"
        let storage = PawStorageManager.PawStorageFile.orderList(userID)
        let response = PawStorageManager.shared.retrieve(storage, from: .caches, as: [BlogBaseModel].self)
        self.blogList = response ?? []
    }

}
