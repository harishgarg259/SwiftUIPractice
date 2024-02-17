//
//  ImageRow.swift
//  UserDisplayApp-SwiftUI
//
//  Created by Harish garg on 20/01/24.
//

import SwiftUI

struct FilterTableRow: View {
    let title: String
    @Binding var selectedRow: String
    
    var body: some View {
        Button(action: {
            selectedRow = title
        }) {
            HStack {
                Text(title)
                    .foregroundColor(Color.black)
                    .font(.footnote)
                    .padding()
                Spacer()
                Image(systemName: title == selectedRow ? "checkmark.circle.fill" : "")
                    .foregroundColor(title == selectedRow ? .themeColor : .clear)
                    .padding(.trailing, 5)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
        .background(.white)
    }
}

struct FilterTableRow_Previews: PreviewProvider {
    static var previews: some View {
        FilterTableRow(title: "Harish", selectedRow: .constant(""))
    }
}
