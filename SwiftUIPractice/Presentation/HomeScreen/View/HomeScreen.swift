//
//  HomeScreen.swift
//  Yappetizer
//
//  Created by Harish Garg on 04/02/24.
//

import SwiftUI
import ActivityIndicatorView

struct HomeScreen: View {
    
    let categories: [String] = ["Our Brand","Dog", "Cat"]
    @State private var selectedCategory: String = "Our Brand"
    let subCategories: [String] = ["All","Charmy","KaliWags", "Earth Rated", "Smack","Dog Delights", "NutriBites", "Sensitivia"]
    @State private var selectedSubCategory: String = "All"
    @Namespace var category
    @Namespace var subCategory
    
    @Binding var showMenu: Bool
    @State private var searchText: String = ""
    @State private var presented = false
    @State var showFab = true
    @State var scrollOffset: CGFloat = 0.00
    @StateObject var viewModel = HomeViewModel()
    @State var showLoadingIndicator = false
    @State var tags: [String] = []
    @State var keyword: String = ""
    @EnvironmentObject var cart: CartViewModel

    // 1. Number of items will be display in row
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible()),
    ]
    // 2. Fixed height of card
    let height: CGFloat = 200
    // 3. Get mock cards data
    
    var body: some View {
        NavigationStack {
            ScrollView {
                TagTextField(tags: $tags, keyword: $keyword, tagRemoved:  { isDeleted in
                    if isDeleted{
                        viewModel.localProductList()
                    }
                })
                if viewModel.isLoading {
                    ProgressView()
                } else if !viewModel.productListArray.isEmpty{
                    HStack() {
                        ForEach(categories, id: \.self) { segment in
                            Button {
                                selectedCategory = segment
                                selectedSubCategory = "All"
                            } label: {
                                VStack {
                                    HStack{
                                        Text(segment)
                                            .font(.headline)
                                            .fontWeight(.medium)
                                            .foregroundColor(selectedCategory == segment ? .red : Color(uiColor: .systemGray))
                                    }
                                    ZStack {
                                        Capsule()
                                            .fill(Color.clear)
                                            .frame(height: 4)
                                        if selectedCategory == segment {
                                            Capsule()
                                                .fill(Color.red)
                                                .frame(height: 3)
                                                .matchedGeometryEffect(id: "Tab", in: category)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(5)
                    
                    ScrollView(.horizontal,showsIndicators: false) {
                        HStack() {
                            ForEach(subCategories, id: \.self) { segment in
                                Button {
                                    selectedSubCategory = segment
                                } label: {
                                    VStack {
                                        HStack{
                                            Text(segment)
                                                .font(.headline)
                                                .fontWeight(.medium)
                                                .foregroundColor(selectedSubCategory == segment ? .red : Color(uiColor: .systemGray))
                                                .padding()
                                        }
                                        ZStack {
                                            Capsule()
                                                .fill(Color.clear)
                                                .frame(height: 4)
                                            if selectedSubCategory == segment {
                                                Capsule()
                                                    .fill(Color.red)
                                                    .frame(height: 3)
                                                    .matchedGeometryEffect(id: "Tab", in: subCategory)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(5)
                    }
                    
                    
                    listView
                    
                    .background(GeometryReader {
                        return Color.clear.preference(key: ViewOffsetKey.self, value: -$0.frame(in: .named("scroll")).origin.y)
                    })
                    .onPreferenceChange(ViewOffsetKey.self) { offset in
                        withAnimation {
                            if offset > 50 {
                                showFab = offset < scrollOffset
                            } else  {
                                showFab = true
                            }
                        }
                        scrollOffset = offset
                    }
                } else {
                    Text("No products found")
                }
               
            }
            .coordinateSpace(name: "scroll")
            .overlay(
                showFab ? createFab(): nil,
                alignment: Alignment.bottomTrailing
            )
            .navigationTitle("Products")
            .searchable(text: $searchText)
//            .navigationBarItems(trailing: trailingBarItems)
//            .navigationBarItems(leading: leadingBarItems)
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbarBackground(.visible, for: .navigationBar)
        }
        .overlay(
            ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .default())
                .frame(width: 50.0, height: 50.0)
                .foregroundColor(.themeColor)
        )
        .tint(.themeColor)
    }
    
    func searchProducts(for searchText: String) {
        if !searchText.isEmpty {
            self.viewModel.productList(searchText: searchText)
        }else{
            viewModel.productListArray.removeAll()
        }
    }
    
    var listView: some View {
        // 4. Populate into grid
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(viewModel.productListArray, id: \.id) { element in
                ProductView(productDetail: element)
                    .environmentObject(cart)
                    .frame(height: height)
            }
        }
        .padding()
        .onSubmit(of: .search) {
            if tags.contains(searchText) == false {
                tags.append(searchText)
            }
            searchProducts(for: searchText)
        }
    }
    
    fileprivate func createFab() -> some View {
        return Button(action: {
            self.presented = true
        }, label: {
            Image(systemName: "slider.horizontal.2.square")
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 35, height: 35, alignment: .center)
        })
        .sheet(isPresented: $presented) {
            FilterView(showScreen: .constant(false), viewModel: CatagoryViewModel()) { text in
                tags.removeAll()
                tags.append(text)
                searchProducts(for: text)
            }
        }
        .padding(10)
        .background(Color.themeColor)
        .cornerRadius(15)
        .padding(15)
        .shadow(radius: 3,
                x: 3,
                y: 3)
        .transition(.scale)
    }
    
    var trailingBarItems: some View {
        NavigationLink(destination:
            CartView(cartProducts: cart)
        )
        {
            Image(systemName: "cart")
                .font(.system(size: 20))
        }
        .overlay(Badge(count: cart.cartProduct.count))
    }
    
    var leadingBarItems: some View {
        Button(action: {
            withAnimation {
                showMenu.toggle()
            }
        }) {
            Image(systemName: "list.bullet")
                .font(.system(size: 20))
        }
        .padding(5)
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

#Preview {
    HomeScreen(showMenu: .constant(true))
}
