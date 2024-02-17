//
//  OrderListing.swift
//  Yappetizer
//
//  Created by Harish Garg on 04/02/24.
//

import SwiftUI

struct OrderListing: View {
        
    let cards: [String] = ["Kangroo","Venison","Kangroo","Venison","Kangroo","Venison","Kangroo","Venison","Kangroo","Venison"]
    
    var body: some View {
        NavigationStack {
            ForEach(Array(cards.enumerated()), id: \.offset) { section, element in
                OrderRow(title: element)
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .tint(.themeColor)
    }
    
}

#Preview {
    OrderListing()
}
