//
//  OrderListing.swift
//  Yappetizer
//
//  Created by Harish Garg on 04/02/24.
//

import SwiftUI

struct OrderListing: View {
    
    let cards: [String] = ["123456","123456","123456","123456","123456","123456","123456","123456","123456","123456","123456","123456","123456","123456","123456","123456","123456","123456","123456","123456"]
    
    var body: some View {
        List {
            ForEach(Array(cards.enumerated()), id: \.offset) { section, element in
                OrderRow(title: element)
            }
        }
        .navigationTitle("Order Listing")
        .navigationBarTitleDisplayMode(.inline)
        .tint(.themeColor)
    }
    
}

#Preview {
    OrderListing()
}
