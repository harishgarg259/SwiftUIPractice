//
//  ProductDetail.swift
//  Yappetizer
//
//  Created by Harish Garg on 27/02/24.
//

import SwiftUI

struct ProductDetailView: View {
    
    let product: ProductListModel?
    @State private var selectedSizeIndex = 0
    @State private var quantity = 1
    @EnvironmentObject var cart: CartViewModel

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
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Multiple images in grid view with pagination view
                ImageGridView(images: product?.images ?? [])
                    .frame(height: 200) // Set your preferred height
                
                // Product name and price detail after discount
                VStack(alignment: .leading, spacing: 8) {
                    Text(product?.name ?? "Title")
                        .font(.title)
                    HStack {
                        Text("Price:")
                            .font(.headline)
                        if ((product?.regular_price ?? "") != ""){
                            Text("$\(product?.regular_price ?? "")")
                                .font(.headline)
                                .strikethrough()
                        }
                        Text("$\(product?.price ?? "")")
                            .font(.headline)
                    }
                }
                
                if !(product?.in_stock ?? true){
                    Text("Out Of Stock")
                        .font(.headline)
                        .foregroundStyle(.red)
                }else{
                    if let sizes = product?.attributes?.filter({ $0.name == "SIZE" }), let options = sizes.first?.options, options.count > 0{
                        // Choose Size Dropdown
                        HStack {
                            Text("Select Size:")
                                .font(.headline)
                            Spacer()
                            Picker("Select Size", selection: $selectedSizeIndex) {
                                ForEach(0..<options.count, id: \.self) { index in
                                    Text(options[index])
                                }
                            }
                            .pickerStyle(.menu)
                            .tint(.themeColor)
                        }
                    }
                    
                    // Quantity Stepper
                    Stepper(value: $quantity, in: 1...(product?.stock_quantity ?? 20)) {
                        Text("Quantity: \(quantity)")
                            .font(.headline)
                    }
                    
                    // Add to cart button
                    Button {
                        cart.addToCart(addedProduct: product, quantity: 1)
                    } label: {
                        Text("Add to Cart")
                            .frame(maxWidth: .infinity)
                            .fontWeight(.bold)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .shadow(color: .themeColor,radius: 2)
//                    .disabled(product?.atum_stock_status == "outofstock")
                }
                
               
                
                // Product Categories
                VStack(alignment: .leading, spacing: 12) {
                    Text("SKU: N/A Categories:")
                        .font(.headline)
                    let categories = product?.categories?.map({$0.name ?? ""}).joined(separator: ", ")
                    Text(categories ?? "No Categories")
                        .font(.body)
                }
                
                // Product description with multiple headings and details
                VStack(alignment: .leading, spacing: 12) {
                    Text("Description")
                        .font(.headline)
                    Text(product?.description ?? "")
                        .font(.body)
                }
                
                // Similar product listing at the end
//                Text("Related Products")
//                    .font(.title)
                
                // 4. Populate into grid
//                LazyVGrid(columns: columns, spacing: 20) {
//                    ForEach(Array(cards.enumerated()), id: \.offset) { section, element in
//                        ProductView(imageDetail: sampleProduct, productName: element)
//                            .frame(height: height)
//                    }
//                }
            }
            .padding()
        }
        .navigationTitle("Product Detail")
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

struct Product {
    let name: String
    let price: Double
    let discountedPrice: Double
    let images: [String]
    let sizes: [String]
    let description: ProductDescription
}

struct ProductDescription {
    let headings: [String]
    let details: [String: String]
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductDetailView(product: nil)
        }
    }
}


#Preview {
    ProductDetailView(product: nil)
}
