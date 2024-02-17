//
//  AddressView.swift
//  Yappetizer
//
//  Created by Harish Garg on 22/01/24.
//

import SwiftUI

struct AddressView: View {
    
    let myAddressOptions: [String] = ["Billing address","Shipping address"]
    var body: some View {
        VStack {
            List(Array(myAddressOptions.enumerated()), id: \.offset) { index, contact in
                AddressListCellView(index: index, title: contact)
            }
        }
        .navigationBarTitle("Addresses",displayMode: .inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .tint(.themeColor)
    }
}

#Preview {
    AddressView()
}

struct AddressListCellView: View {
    var index: Int
    var title: String
    var body: some View {
        return   NavigationLink(destination: AddressViewFactory.create(index, title: title))  {
            Text(title)
                .fontWeight(.medium)
        }
    }
}

class AddressViewFactory {
    static func create(_ index: Int, title: String) -> AnyView {
        switch index {
        case 0:
            return AnyView(AddressDetailView(headerTitle: title))
        case 1:
            return AnyView(AddressDetailView(headerTitle: title))
        default:
            return AnyView(EmptyView())
        }
    }
}
