//
//  OrderRow.swift
//  UserDisplayApp-SwiftUI
//
//  Created by Harish garg on 20/01/24.
//

import SwiftUI

struct OrderRow: View {
    let title: String
    
    var body: some View {
        Button(action: {
        }) {
            HStack {
                Text(title)
                    .foregroundColor(Color.black)
                    .font(.footnote)
                    .padding()
                Spacer()
            }
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
        .background(.white)
    }
}

struct OrderRow_Previews: PreviewProvider {
    static var previews: some View {
        FilterTableRow(title: "Harish", selectedRow: .constant(""))
    }
}
