//
//  DetailView.swift
//  Yappetizer
//
//  Created by Harish Garg on 22/01/24.
//

import SwiftUI

struct ProfileView: View {
    
    
    @StateObject var userModel: UserProfileViewModel

    
    let myProfileOptions: [String] = ["Orders","Addresses","Payment methods","Account details","Update Password"]
    var body: some View {
        VStack {
            List(Array(myProfileOptions.enumerated()), id: \.offset) { index, contact in
                ListCellView(index: index, title: contact)
            }
        }
        .onAppear{
            self.userModel.getProfile()
        }
        .navigationBarTitle("My Profile",displayMode: .inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .tint(.themeColor)
    }
}

#Preview {
    ProfileView(userModel: UserProfileViewModel())
}

struct ListCellView: View {
    var index: Int
    var title: String
    var body: some View {
        return   NavigationLink(destination: ViewFactory.create(index))  {
            Text(title)
                .fontWeight(.medium)
        }
    }
}

class ViewFactory {
    static func create(_ index: Int) -> AnyView {
        switch index {
        case 0:
            return AnyView(OrderListing())
        case 1:
            return AnyView(AddressView(viewModel: AddressViewModel()))
        case 2:
            return AnyView(PaymentMethod())
        case 3:
            return AnyView(ProfileDetailView())
        case 4:
            return AnyView(ChangePasswordView())
        default:
            return AnyView(EmptyView())
        }
    }
}
