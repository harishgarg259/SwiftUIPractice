//
//  AddressView.swift
//  Yappetizer
//
//  Created by Harish Garg on 22/01/24.
//

import SwiftUI

struct CustomerAddresses: Identifiable {
    var id = UUID()
    var isSelected : Bool = false
    var addressDetail: AddressDetail?
}

struct AddressGroup: Identifiable {
    
    var id = UUID()
    var addressType : String
    var address : [CustomerAddresses]
    var expandMe : Bool
}

class AddressViewModel: ObservableObject {
    
    @Published var addresses: [AddressGroup] = []
    
    func customerProfile() -> CustomerProfile? {
        let userID = "\(UserDefaultsManager.userID ?? 0)"
        let storage = PawStorageManager.PawStorageFile.customerDetail(userID)
        let response = PawStorageManager.shared.retrieve(storage, from: .caches, as: CustomerProfile.self)
        return response
    }
    
    func prepareAddressArray() {
        
        let customerProfile = customerProfile()
        self.addresses.removeAll()
        if let billingAddress = customerProfile?.billing {
            let detail = AddressGroup(addressType: "Billing Address", address: [
                CustomerAddresses(addressDetail: billingAddress)
            ], expandMe: true)
            self.addresses.append(detail)
        }
        if let shippingAddress = customerProfile?.shipping {
            let detail = AddressGroup(addressType: "Shipping Address", address: [
                CustomerAddresses(addressDetail: shippingAddress)
            ], expandMe: true)
            self.addresses.append(detail)
        }
    }
}


struct AddressView: View {
    
    @StateObject var viewModel: AddressViewModel = AddressViewModel()
    
    var body: some View {
        VStack {
            if !viewModel.addresses.isEmpty{
                List {
                    ForEach(Array(viewModel.addresses.enumerated()), id: \.offset) { index, element in
                        DisclosureGroup(element.addressType, isExpanded: .constant(true)) {
                            ForEach(Array(element.address.enumerated()), id: \.offset) { index, address in
                                AddressListCellView(address: element, index: index)
                            }.listRowInsets(.init(top: 0, leading: -8, bottom: 0, trailing: 0))
                        }
                        .accentColor(.clear)
                    }
                    .accentColor(.clear)
                }
            }
        }
        .onAppear(perform: {
            self.viewModel.prepareAddressArray()
        })
        .navigationBarTitle("Addresses",displayMode: .inline)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    AddressView(viewModel: AddressViewModel())
}

struct AddressListCellView: View {
    var address: AddressGroup?
    var index: Int
    var body: some View {
        return   ZStack {
            HStack {
                addressView(address: address)
                Spacer()
                Image(systemName: "pencil")
                    .renderingMode(.template)
                    .foregroundColor(.gray)
                    .padding(.trailing, 15)
            }
            NavigationLink(destination: AddressDetailView(headerTitle: address?.addressType ?? "", addressDetail: address))  {
            }.opacity(0)
        }
    }
    
    func addressView(address: AddressGroup?) -> some View{
        return VStack(alignment: .leading, spacing: 8) {
            Text(((address?.address[0].addressDetail?.address_1?.isEmpty ?? true) ? "No Address" : address?.address[0].addressDetail?.address_1) ?? "")
                .font(.title)
                .fontWeight(.bold)
            
            if let address1 = address?.address[0].addressDetail?.address_1, !address1.isEmpty
            {
                Text(address1)
                    .font(.body)
            }
            if let address2 = address?.address[0].addressDetail?.address_2, !address2.isEmpty
            {
                Text(address2)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            if let city = address?.address[0].addressDetail?.city, let postcode = address?.address[0].addressDetail?.postcode, !city.isEmpty
            {
                Text("\(city), \(postcode)")
                    .font(.body)
            }
            if let country = address?.address[0].addressDetail?.country, !country.isEmpty
            {
                Text(country)
                    .font(.footnote)
                    .italic()
            }
            if let phone = address?.address[0].addressDetail?.phone, !phone.isEmpty
            {
                Text("(Contact: \(phone))")
                    .font(.footnote)
                    .italic()
            }
        }
        .padding()
    }
}
