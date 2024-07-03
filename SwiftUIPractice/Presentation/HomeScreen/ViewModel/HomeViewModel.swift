//
//  HomeViewModel.swift
//  Yappetizer
//
//  Created by Harish Garg on 11/06/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    var subscriptions = Set<AnyCancellable>()
    @Published var productListArray: [ProductListModel] = []
    @Published var searchTerm: String = ""
    @Published var state: FetchState = .idle
    @Published var catagoryListArray: CatagoryModel?
    @Published var menuListArray: [MenuObject] = []
    @Published var subMenus : [MenuChildren] = []
    
    @Published var selectedCategory: String = ""{
        didSet {
            self.state = .idle
            self.productList(searchText: selectedCategory)
        }
    }
    @Published var selectedSubCategory: String = ""{
        didSet {
            self.state = .idle
            self.productList(searchText: selectedSubCategory)
        }
    }
    

    init() {
        
        //Intially load from local
        localFilterList()
        localProductList()
        
        $searchTerm
            .dropFirst()
            .removeDuplicates()
            .debounce(for: .seconds(1.0), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.state = .idle
                self?.productListArray = []
                self?.productList(searchText: term)
            }.store(in: &subscriptions)
    }
    
    func productList(searchText: String) {
        
        guard !searchText.isEmpty else {
            return
        }
        
        guard state == FetchState.idle else {
            return
        }
        
        state = .isLoading
        
        let parameters = ["page":1, "per_page": AppConstants.limitPerPage,"consumer_key":AppConstants.Consumer_Key, "consumer_secret": AppConstants.Consumer_Secret,"search":searchText,"status":"publish","_fields":AppConstants.ProductListFields] as [String : Any]
        let rest = RestManager<[ProductListModel]>()
        rest.makeRequest(request : WebAPI().productRequest(params : parameters, type: .productList)!) { (result) in
            switch result {
            case .success(let response):
                
                
                debugPrint(response)
                self.productListArray = response
                
                if response.isEmpty{
                    self.state = .error("No Product Found")
                } else {
                    self.state = .loadedAllProducts
                }
                
                if searchText.isEmpty{
                    self.saveLocalCache(response: response)
                }
                
            case .failure(let error):
                debugPrint(error.description)
                self.productListArray = []
                self.state = .error(error.description)
            }
        }
    }
    
    func catagoryList() {
        let parameters = ["page":1, "per_page": 100] as [String : Any]
        let rest = RestManager<CatagoryModel>()
        rest.makeRequest(request : WebAPI().productRequest(params : parameters, type: .catagory)!) { (result) in
            switch result {
            case .success(let response):
                debugPrint(response)
                if self.productListArray.isEmpty{
                    //Load from api
                    self.productList(searchText: "")
                }
                self.catagoryListArray = response
                self.filterList()
            case .failure(let error):
                debugPrint(error.description)
            }
        }
    }
    
}

extension HomeViewModel{
    
    func filterList() {
        guard let list = self.catagoryListArray else { return }
        let menuListArray = list.items?.filter({!($0.children?.isEmpty ?? true)}) ?? []
        
        for menu in menuListArray{
            let menuItem = MenuObject(menuName: menu.title ?? "", subMenus: menu.children ?? [], expandMe: true)
            self.menuListArray.append(menuItem)
        }
        
        saveCategoriesCache(response: self.menuListArray)
    }
    
    func saveCategoriesCache(response: [MenuObject]) {
        let storage = PawStorageManager.PawStorageFile.filterList
        PawStorageManager.shared.store(response, to: .caches, as: storage)
    }
    
    func localFilterList() {
        let storage = PawStorageManager.PawStorageFile.filterList
        let response = PawStorageManager.shared.retrieve(storage, from: .caches, as: [MenuObject].self)
        self.menuListArray = response ?? []
        if self.menuListArray.isEmpty{
            //Load from api
            catagoryList()
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
        if !self.menuListArray.isEmpty && self.productListArray.isEmpty{
            //Load from api
            self.productList(searchText: "")
        }else{
            self.state = .loadedAllProducts
        }
    }
    
}
