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
        .navigationBarTitle("Order Listing",displayMode: .inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .tint(.themeColor)
    }
    
}

#Preview {
    OrderListing()
}
