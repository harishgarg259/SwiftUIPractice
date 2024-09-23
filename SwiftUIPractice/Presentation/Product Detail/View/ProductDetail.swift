//
//  ProductDetail.swift
//  Yappetizer
//
//  Created by Harish Garg on 27/02/24.
//

import WebKit
import SwiftUI

struct ProductDetailView: View {
    
    @EnvironmentObject var cart: CartViewModel
    @ObservedObject var viewModel: ProductDetailViewModel
    let product: ProductListModel?

//    @Binding var badgeCount : Int

    // 1. Number of items will be display in row
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible()),
    ]
    // 2. Fixed height of card
    let height: CGFloat = 200
    // 3. Get mock cards data
    let cards: [String] = ["Kangroo","Venison","Kangroo","Venison"]

    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        if !(viewModel.name?.isEmpty ?? true){
                            
                            // Multiple images in grid view with pagination view
                            ImageGridView(images: viewModel.images ?? [])
                                .frame(height: 200) // Set your preferred height
                            
                            // Product name and price detail after discount
                            VStack(alignment: .leading, spacing: 8) {
                                Text(viewModel.name ?? "Title")
                                    .font(.title)
                                HStack {
                                    Text("Price:")
                                        .font(.headline)
                                    if !(viewModel.regular_price?.isEmpty ?? true){
                                        Text("$\(viewModel.regular_price ?? "")")
                                            .font(.headline)
                                            .strikethrough()
                                    }
                                    Text("$\(viewModel.productPrice ?? "")")
                                        .font(.headline)
                                }
                            }
                            
                            let sizes = viewModel.variations.map({$0.attributes?.first?.option ?? ""})
                            if sizes.isEmpty{
                                if let sizes = viewModel.attributes?.filter({
                                    ($0.name?.uppercased() ?? "").contains("SIZE")
                                }),
                                   let options = sizes.first?.options,
                                   options.count > 0
                                {
                                    // Choose Size Dropdown
                                    HStack {
                                        Text("Select Size:")
                                            .font(.headline)
                                        Spacer()
                                        MyCustomPicker(pickerData: options, binding: $viewModel.selectedSizeIndex)
                                    }
                                }
                            }else{
                                HStack {
                                    Text("Select Size:")
                                        .font(.headline)
                                    Spacer()
                                    MyCustomPicker(pickerData: sizes, binding: $viewModel.selectedSizeIndex)
                                }
                            }
                            
                            if !(viewModel.in_stock ?? true){
                                Text("Out Of Stock")
                                    .font(.headline)
                                    .foregroundStyle(.red)
                            }else{
                                
                                // Quantity Stepper
                                Stepper(value: $viewModel.quantity, in: 1...(viewModel.stock_quantity ?? 20)) {
                                    VStack(alignment: .leading, spacing: 0){
                                        Text("Quantity: \(self.viewModel.quantity)")
                                            .font(.headline)
                                        Text("Available: \(viewModel.stock_quantity ?? 20)")
                                            .font(.system(size: 14))
                                            .foregroundStyle(.red)
                                    }
                                }
                                
                                // Add to cart button
                                Button {
                                    cart.addProduct(product: viewModel.cartProduct, quantity: self.viewModel.quantity)
                                } label: {
                                    Text("Add to Cart")
                                        .frame(maxWidth: .infinity)
                                        .fontWeight(.bold)
                                }
                                .buttonStyle(.borderedProminent)
                                .controlSize(.large)
                                .shadow(color: .themeColor,radius: 2)
                            }
                            
                            // Product Categories
                            VStack(alignment: .leading, spacing: 12) {
                                Text("SKU: N/A Categories:")
                                    .font(.headline)
                                let categories = viewModel.categories?.map({$0.name ?? ""}).joined(separator: ", ")
                                Text(categories ?? "No Categories")
                                    .font(.body)
                            }
                            descriptionView
                        }else{
                            ProgressView("Loading...")
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear(perform: {
            self.viewModel.product = self.product
            self.viewModel.productVariations()
        })
        .navigationTitle("Product Detail")
    }
    
    var descriptionView: some View {
        // Product description with multiple headings and details
        VStack(alignment: .leading, spacing: 12) {
            Text("Description")
                .font(.headline)
            Text(self.viewModel.description ?? "")
                .font(.body)
                .task {
                    self.viewModel.description = await .decodeHTMLString(self.viewModel.encodedDescription ?? "") ?? ""
                }
        }
    }
}

struct ImageGridView: View {
    let images: [ProductImages]
    @State private var currentPage = 0
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(Array(images.enumerated()), id: \.offset) { section, element in
                    if let imageURL = element.src {
                        ImageView(url: imageURL)
                            .scaledToFit()
                            .tag(element.name)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .onAppear {
                setupAppearance()
            }
        }
    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
}

struct MyCustomPicker: View {
    var pickerData: [String]
    @Binding var binding: Int
    var body: some View {
        Picker("Select Size", selection: $binding) {
            ForEach(0 ..< pickerData.count, id: \.self)
            { i in
                Text(self.pickerData[i])
            }
        }
        .pickerStyle(.menu)
        .tint(.themeColor)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductDetailView(viewModel: ProductDetailViewModel(), product: nil)
        }
    }
}


#Preview {
    ProductDetailView(viewModel: ProductDetailViewModel(), product: nil)
}
