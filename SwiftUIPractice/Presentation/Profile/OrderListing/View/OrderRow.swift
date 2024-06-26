//
//  OrderRow.swift
//  UserDisplayApp-SwiftUI
//
//  Created by Harish garg on 16/02/24.
//

import SwiftUI

struct OrderRow: View {
    let orderDetail: OrderList?
    
    var body: some View {
        NavigationLink(destination: OrderDetail(orderDetail: orderDetail)) {
            HStack {
                VStack(alignment: .leading,spacing: 5, content: {
                    HStack {
                        Text("Order:")
                            .foregroundColor(.primary)
                            .font(.system(size: 16, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        Text("#\(orderDetail?.id ?? 0)")
                            .foregroundColor(Color.blue)
                            .font(.system(size: 15, weight: .medium))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                    HStack {
                        Text("Date:")
                            .foregroundColor(.primary)
                            .font(.system(size: 16, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        Text("\((orderDetail?.date_modified ?? "").formatDate(date: "MMM d, yyyy"))")
                            .foregroundColor(.primary)
                            .font(.system(size: 15, weight: .medium))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                    HStack {
                        Text("Total:")
                            .foregroundColor(.primary)
                            .font(.system(size: 16, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        Text("$\(orderDetail?.total ?? "")")
                            .foregroundColor(.primary)
                            .font(.system(size: 15, weight: .medium))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                })
                Spacer()
                VStack {
                    HStack (alignment: .top, content: {
                        Text("Status:")
                            .foregroundColor(.primary)
                            .font(.system(size: 16, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        Text("\(orderDetail?.status ?? "Unknown")".capitalized)
                            .foregroundColor(.primary)
                            .font(.system(size: 15, weight: .medium))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    })
                    .padding(.top, 5)
                    Spacer()
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
        .background(.white)
        }
    }
}

struct OrderRow_Previews: PreviewProvider {
    static var previews: some View {
        OrderRow(orderDetail: nil)
    }
}
