//
//  AddressView.swift
//  Yappetizer
//
//  Created by Harish Garg on 22/01/24.
//

import SwiftUI

class AddressViewModel: ObservableObject {
    
    @Published var addresses = [
        AnimalGroup(groupName: "Billing address", animals: [
            Animal(name: "No Address")
        ], expandMe: true),
        AnimalGroup(groupName: "Shipping address", animals: [
            Animal(name: "No Address")
        ], expandMe:true)
    ]

    init() {
    }
}


struct AddressView: View {
    
    @ObservedObject var addresses: AddressViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(Array(addresses.addresses.enumerated()), id: \.offset) { section, element in
                    DisclosureGroup(element.groupName, isExpanded: .constant(true)) {
                        ForEach(Array(element.animals.enumerated()), id: \.offset) { index, animal in
                            AddressListCellView(index: index, title: animal.name)
                        }.listRowInsets(.init(top: 0, leading: -8, bottom: 0, trailing: 0))
                    }
                    .accentColor(.clear)
                }
                .accentColor(.clear)
            }
        }
        .navigationBarTitle("Addresses",displayMode: .inline)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    AddressView(addresses: AddressViewModel())
}

struct AddressListCellView: View {
    var index: Int
    var title: String
    var body: some View {
        return   ZStack {
            HStack {
                Text(title)
                    .padding()
                    .fontWeight(.regular)
                    .foregroundColor(.gray)
                Spacer()
                Image(systemName: "pencil")
                    .renderingMode(.template)
                    .foregroundColor(.gray)
                    .padding(.trailing, 15)
            }
            NavigationLink(destination: AddressViewFactory.create(index, title: title))  {
            }.opacity(0)
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
