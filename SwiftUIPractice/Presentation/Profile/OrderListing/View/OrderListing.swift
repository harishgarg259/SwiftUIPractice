//
//  OrderListing.swift
//  Yappetizer
//
//  Created by Harish Garg on 04/02/24.
//

import SwiftUI

struct OrderListing: View {
        
    @StateObject var orderViewModel: OrderListViewModel = OrderListViewModel()
    
    var body: some View {
        List {
            ForEach(Array(orderViewModel.orderList.enumerated()), id: \.offset) { section, element in
                OrderRow(orderDetail: element)
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
