//
//  HomeScreen.swift
//  Yappetizer
//
//  Created by Harish Garg on 04/02/24.
//

import SwiftUI

struct HomeScreen: View {
    
    // MARK: - Properties
    
    // State variables
    @State private var searchText: String = ""
    @StateObject private var viewModel = HomeViewModel()
    
    // Environment objects
    @EnvironmentObject private var cart: CartViewModel
    
    // Grid configuration
    private var columns: [GridItem] {
        [GridItem(.flexible(), spacing: 20), GridItem(.flexible())]
    }
    private let cardHeight: CGFloat = 200
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                categoryView
                subCategoryView
                
                switch viewModel.state {
                case .idle:
                    Color.clear
                        .onAppear {
                            //viewModel.loadMore()
                        }
                case .isLoading:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(maxWidth: .infinity)
                case .loadedAllProducts:
                    productListView
                case .error(let message):
                    Text(message)
                        .foregroundColor(.pink)
                }
            }
            .navigationTitle("Products")
            .searchable(text: $searchText)
            .onSubmit(of: .search) {
                self.searchProducts(searchText: searchText)
            }
        }
        .tint(.themeColor)
    }
    
    // MARK: - Methods
    
    private func searchProducts(searchText: String) {
        if !searchText.isEmpty {
            viewModel.productList(searchText: searchText)
        } else {
            viewModel.productListArray.removeAll()
        }
    }
    
    // MARK: - Views
    
    private var productListView: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(viewModel.productListArray, id: \.id) { product in
                ProductView(productDetail: product)
                    .environmentObject(cart)
                    .frame(height: cardHeight)
            }
        }
        .padding()
    }
    
    private var categoryView: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(Array(viewModel.menuListArray.enumerated()), id: \.offset) { section, element in
                        Button {
                            viewModel.subMenus = element.subMenus
                            viewModel.selectedCategory = element.menuName
                            viewModel.selectedSubCategory = element.subMenus.first?.title ?? ""
                        } label: {
                            VStack {
                                Text(element.menuName)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(viewModel.selectedCategory == element.menuName ? .red : .secondary)
                                ZStack {
                                    Capsule()
                                        .fill(Color.clear)
                                        .frame(height: 4)
                                    if viewModel.selectedCategory == element.menuName {
                                        Capsule()
                                            .fill(Color.red)
                                            .frame(height: 3)
                                    }
                                }
                            }
                            .padding([.leading, .trailing], 10)
                        }
                    }
                }
                .padding([.leading, .trailing], 16)
            }
            Divider()
                .frame(height: 2)
                .padding(.top, 0)
        }
    }
    
    private var subCategoryView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(Array(viewModel.subMenus.enumerated()), id: \.offset) { index, subCategory in
                    Button {
                        viewModel.selectedSubCategory = subCategory.title ?? ""
                    } label: {
                        Text(subCategory.title ?? "")
                            .foregroundColor(viewModel.selectedSubCategory == subCategory.title ?? "" ? .white : .theme)
                            .padding()
                            .frame(height: 36)
                            .background(
                                Capsule()
                                    .strokeBorder(.red, lineWidth: 2)
                                    .background(Capsule().fill(viewModel.selectedSubCategory == subCategory.title ?? "" ? .red : .white))
                            )
                    }
                }
            }
            .padding([.leading, .trailing], 16)
        }
    }
    
    // MARK: - Navigation Bar Items
    
    var trailingBarItems: some View {
        NavigationLink(destination: CartView(viewModel: cart)) {
            Image(systemName: "cart")
                .font(.system(size: 20))
        }
        .overlay(Badge(count: cart.cartArray.count))
    }
}

// MARK: - Preference Key

struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

#Preview {
    HomeScreen()
}
