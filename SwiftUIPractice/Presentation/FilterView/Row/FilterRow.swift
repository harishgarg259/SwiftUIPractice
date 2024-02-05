//
//  ImageRow.swift
//  UserDisplayApp-SwiftUI
//
//  Created by Harish garg on 20/01/24.
//

import SwiftUI

struct FilterTableRow: View {
    let title: String
    let index: Int
    @Binding var markIndex: Int
    
    var body: some View {
        Button(action: {
            markIndex = index
        }) {
            HStack {
                Text(title)
                    .foregroundColor(Color.black)
                    .font(.footnote)
                    .padding()
                Spacer()
                if index == markIndex {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.clear)
                }else{
                    Image(systemName: "")
                        .foregroundColor(.clear)
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
        .background(.white)
    }
}

struct FilterTableRow_Previews: PreviewProvider {
    static var previews: some View {
        FilterTableRow(title: "Harish", index: 0, markIndex: .constant(0))
    }
}
