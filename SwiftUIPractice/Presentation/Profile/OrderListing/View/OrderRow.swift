//
//  OrderRow.swift
//  UserDisplayApp-SwiftUI
//
//  Created by Harish garg on 16/02/24.
//

import SwiftUI

struct OrderRow: View {
    let title: String
    
    var body: some View {
        NavigationLink(destination: OrderDetail(orderTitle: title)) {
            HStack {
                VStack(alignment: .leading, content: {
                    HStack {
                        Text("Order:")
                            .foregroundColor(.primary)
                            .font(.system(size: 16, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        Text("#\(title)")
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
                        Text("16 Feb 2024")
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
                        Text("$240")
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
                        Text("Completed")
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
        OrderRow(title: "123456")
    }
}
