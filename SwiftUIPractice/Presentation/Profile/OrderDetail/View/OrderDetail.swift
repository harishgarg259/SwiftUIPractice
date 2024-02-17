//
//  OrderDetail.swift
//  Yappetizer
//
//  Created by Harish Garg on 16/02/24.
//

import SwiftUI

struct OrderDetail: View {
    
    var orderTitle: String
        
    let cards: [String] = ["123456","123456","123456","123456","123456","123456","123456","123456","123456","123456","123456","123456","123456","123456","123456","123456","123456","123456","123456","123456"]
    
    var body: some View {
        VStack {
            Text(orderTitle)
        }
        .navigationTitle("Order Detail")
        .navigationBarTitleDisplayMode(.inline)
        .tint(.themeColor)
    }
    
}

#Preview {
    OrderDetail(orderTitle: "Order Title")
}
