//
//  ProductDetail.swift
//  Yappetizer
//
//  Created by Harish Garg on 27/02/24.
//

import SwiftUI

// Example usage:
let sampleProduct = Product(name: "Sample Product", price: 49.99,
                            discountedPrice: 39.99,
                            images: ["pork-liver", "pork-liver", "pork-liver"], sizes: ["Small", "Medium", "Large"],
                            description: ProductDescription(headings: ["Description", "Direction"],
                                                            details: ["Description": "Yappetizers Bison Liver Food topper for dogs is made from 100% human grade bison liver. Our bison liver is dehydrated slowly over 20 hours to ensure natural shelf stability without any added additives or preservatives. Bison liver is high in protein and low in fat and cholesterol. Our bison food enhancer is rich in vitamin A and vitamin B which can aid in our dog’s overall dogs health including skin, joints, coat and immune system.",
                                                                      "Direction": "Simply sprinkle on wet or dry food to help stimulate your dog or cats appetite. Can be used with each meal."]))

struct ProductDetailView: View {
    
    let product: Product
    @State private var selectedSizeIndex = 0
    @State private var quantity = 1
    @Binding var badgeCount : Int

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
                ImageGridView(images: product.images)
                    .frame(height: 200) // Set your preferred height
                
                // Product name and price detail after discount
                VStack(alignment: .leading, spacing: 8) {
                    Text(product.name)
                        .font(.title)
                    HStack {
                        Text("Price:")
                            .font(.headline)
                        Text("$\(product.price, specifier: "%.2f")")
                            .font(.headline)
                            .strikethrough()
                        Text("$\(product.discountedPrice, specifier: "%.2f")")
                            .font(.headline)
                    }
                }
                
                // Choose Size Dropdown
                HStack {
                    Text("Select Size:")
                        .font(.headline)
                    Spacer()
                    Picker("Select Size", selection: $selectedSizeIndex) {
                        ForEach(0..<product.sizes.count, id: \.self) { index in
                            Text(product.sizes[index])
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.themeColor)
                }
                
                // Quantity Stepper
                Stepper(value: $quantity, in: 1...10) {
                    Text("Quantity: \(quantity)")
                        .font(.headline)
                }
                
                // Add to cart button
                Button {
                    
                } label: {
                    Text("Add to Cart")
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .shadow(color: .themeColor,radius: 2)
                //.disabled(selectedSizeIndex <= 0)
                
                // Product description with multiple headings and details
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(product.description.headings, id: \.self) { heading in
                        Text(heading)
                            .font(.headline)
                        Text(product.description.details[heading] ?? "")
                            .font(.body)
                    }
                }
                
                // Similar product listing at the end
                Text("Related Products")
                    .font(.title)
                
                // 4. Populate into grid
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(Array(cards.enumerated()), id: \.offset) { section, element in
                        ProductView(imageDetail: sampleProduct, productName: element, badgeCount: .constant(0))
                            .frame(height: height)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Product Detail")
    }
}

struct ImageGridView: View {
    let images: [String]
    @State private var currentPage = 0
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(images, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .tag(images.firstIndex(of: imageName) ?? 0)
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
            ProductDetailView(product: sampleProduct, badgeCount: .constant(0))
        }
    }
}


#Preview {
    ProductDetailView(product: sampleProduct, badgeCount: .constant(0))
}
