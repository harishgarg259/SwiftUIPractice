//
//  CatagoryViewModel.swift
//  Yappetizer
//
//  Created by Harish Garg on 11/06/24.
//

import Foundation

class CatagoryViewModel: ObservableObject {
    
    @Published var productListArray: CatagoryModel?
    @Published var menuListArray: [MenuObject] = []
    @Published var errorMessage = ""
    @Published var hasError = false
    
    init() {
        //Intially load from local
        localFilterList()
        
        //call api for updated data
        catagoryList()
    }
    
    func catagoryList() {
        let parameters = ["page":1, "per_page": 100] as [String : Any]
        let rest = RestManager<CatagoryModel>()
        rest.makeRequest(request : WebAPI().productRequest(params : parameters, type: .catagory)!) { (result) in
            switch result {
            case .success(let response):
                debugPrint(response)
                self.productListArray = response
                self.hasError = false
                self.errorMessage  = ""
                self.filterList()
            case .failure(let error):
                debugPrint(error.description)
                self.hasError = true
                self.errorMessage  = "Server Error"
            }
        }
    }
}


extension CatagoryViewModel {
    
    func filterList() {
        guard let list = self.productListArray else { return }
        let menuListArray = list.items?.filter({!($0.children?.isEmpty ?? true)}) ?? []
        
        for menu in menuListArray{
            let menuItem = MenuObject(menuName: menu.title ?? "", subMenus: menu.children ?? [], expandMe: true)
            self.menuListArray.append(menuItem)
        }
        
        saveLocalCache(response: self.menuListArray)
    }
    
    func saveLocalCache(response: [MenuObject]) {
        let storage = PawStorageManager.PawStorageFile.filterList
        PawStorageManager.shared.store(response, to: .caches, as: storage)
    }
    
    func localFilterList() {
        let storage = PawStorageManager.PawStorageFile.filterList
        let response = PawStorageManager.shared.retrieve(storage, from: .caches, as: [MenuObject].self)
        self.menuListArray = response ?? []
    }

}
