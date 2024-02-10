//
//  ProductCell.swift
//  SwiftUIPractice
//
//  Created by Harish Garg on 04/02/24.
//

import SwiftUI

struct ProductView: View {
    
    
    let productName: String
    
    var body: some View {
        VStack {
            // Sale badge
            HStack {
                Spacer()
                Text("Sale!")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(15)
                    .background(Color.red)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                    )
                // Adjust padding as needed
                    .padding(5)
            }
            GeometryReader { geo in
                // Product image (assuming you have the image in your assets)
                Image("pork-liver") // Replace with the actual image name
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    .clipped()
                    .background(.green)
            }
            
            // Product title and price
            VStack(alignment: .center) {
                Text(productName)
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                Text("$29.00 - $200.00")
                    .font(.title3)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .padding() // Adjust padding as needed
        }
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5) // Adjust shadow as needed
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(productName: "Pork Liver")
    }
}

