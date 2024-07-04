//
//  ProductDetail.swift
//  Yappetizer
//
//  Created by Harish Garg on 27/02/24.
//

import SwiftUI

struct ProductDetailView: View {
    
    @State private var quantity = 1
    @EnvironmentObject var cart: CartViewModel
    @State var viewModel: ProductDetailViewModel = ProductDetailViewModel()

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
    
    
    init(product: ProductListModel?) {
        self.viewModel.product = product
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Multiple images in grid view with pagination view
                ImageGridView(images: viewModel.product?.images ?? [])
                    .frame(height: 200) // Set your preferred height
                
                // Product name and price detail after discount
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.product?.name ?? "Title")
                        .font(.title)
                    HStack {
                        Text("Price:")
                            .font(.headline)
                        if ((viewModel.product?.regular_price ?? "") != ""){
                            Text("$\(viewModel.product?.regular_price ?? "")")
                                .font(.headline)
                                .strikethrough()
                        }
                        Text("$\(viewModel.product?.price ?? "")")
                            .font(.headline)
                    }
                }
                
                if !(viewModel.product?.in_stock ?? true){
                    Text("Out Of Stock")
                        .font(.headline)
                        .foregroundStyle(.red)
                }else{
                    
                    if !(viewModel.product?.attributes?.isEmpty ?? true){
                        HStack {
                            Text("Select Size:")
                                .font(.headline)
                            Spacer()
                            Picker("Select Size", selection: $viewModel.selectedSizeIndex) {
                                Text("Select Size")
                            }
                            .pickerStyle(.menu)
                            .tint(.themeColor)
                        }
                    }else{
                        let sizes = Array(viewModel.variations.map({$0.attributes?.first?.name ?? ""}))
                        HStack {
                            Text("Select Size:")
                                .font(.headline)
//                                Spacer()
                            MyCustomPicker(pickerData: sizes, binding: $viewModel.selectedSizeIndex)
                        }
                    }
                    
                    // Quantity Stepper
                    Stepper(value: $quantity, in: 1...(viewModel.product?.stock_quantity ?? 20)) {
                        Text("Quantity: \(quantity)")
                            .font(.headline)
                    }
                    
                    // Add to cart button
                    Button {
                        cart.addToCart(addedProduct: viewModel.product, quantity: 1)
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
                    let categories = viewModel.product?.categories?.map({$0.name ?? ""}).joined(separator: ", ")
                    Text(categories ?? "No Categories")
                        .font(.body)
                }
                
//                descriptionView
                
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
        .onAppear(perform: {
            print(self.viewModel.product ?? [])
            self.viewModel.productVariations()
        })
        .navigationTitle("Product Detail")
    }
    
    var descriptionView: some View {
        // Product description with multiple headings and details
        VStack(alignment: .leading, spacing: 12) {
            Text("Description")
                .font(.headline)
            if let attributedText = viewModel.product?.description?.attributedHtmlString {
                Text(attributedText.string)
                    .font(.body)
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
            ProductDetailView(product: nil)
        }
    }
}


#Preview {
    ProductDetailView(product: nil)
}
