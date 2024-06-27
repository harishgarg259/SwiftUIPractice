//
//  ProductCell.swift
//  Yappetizer
//
//  Created by Harish Garg on 04/02/24.
//

import SwiftUI

struct ProductView: View {
    
    @State var productDetail: ProductListModel?
    @EnvironmentObject var cart: CartViewModel

    var body: some View {
        NavigationLink(destination: ProductDetailView(product: productDetail).environmentObject(cart)) {
            VStack {
                // Sale badge
                //                HStack {
                //                    Spacer()
                //                    Text("Sale!")
                //                        .font(.caption)
                //                        .foregroundColor(.white)
                //                        .padding(15)
                //                        .background(Color.red)
                //                        .clipShape(Circle())
                //                        .overlay(
                //                            Circle()
                //                                .stroke(Color.white, lineWidth: 2)
                //                        )
                //                    // Adjust padding as needed
                //                        .padding(5)
                //                }
                
                
                // Product title and price
                VStack(alignment: .center) {
                    
                    ZStack(alignment: .bottomLeading) {
                        GeometryReader { geo in
                            // Product image (assuming you have the image in your assets)
                            if let imageURL = productDetail?.images?[0].src {
                                ImageView(url: imageURL)
                                    .scaledToFit()
                                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                                    .clipped()
                                    .background(.white)
                            }else{
                                Image("pork-liver") // Replace with the actual image name
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                                    .clipped()
                                    .background(.green)
                            }
                        }
                        
                        Button(action: {
                            // Add to cart action
                            print("Item added to cart")
                            cart.addToCart(addedProduct: productDetail, quantity: 1)
                        }) {
                            Text("+ Add")
                                .font(.system(size: 13).bold())
                                .foregroundColor(.white)
                                .padding(2)
                                .frame(width: 60.0, height: 30.0)
                                .background(Color.blue)
                                .cornerRadius(15)
                        }
                        .opacity((!(productDetail?.in_stock ?? true)) ? 0 : 1)
                    }
                    
                    Text(productDetail?.name ?? "Title")
                        .font(.title2)
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    Text("$\(productDetail?.price ?? "$9.99")")
                        .font(.title3)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    if !(productDetail?.in_stock ?? true){
                        Text("Out Of Stock")
                            .foregroundStyle(.red)
                            .font(.footnote)
                    }
                }
                .padding() // Adjust padding as needed
            }
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
        } // Adjust shadow as needed
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(productDetail: nil)
    }
}

