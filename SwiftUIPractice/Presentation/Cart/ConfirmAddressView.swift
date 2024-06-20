//
//  AddressView.swift
//  Yappetizer
//
//  Created by Harish Garg on 22/01/24.
//

import SwiftUI

struct ConfirmAddressView: View {
    
    @ObservedObject var addresses = AddressViewModel()
    @State private var isConfirmed = false
    @State private var isEdit = false
    @StateObject var viewModel = SubscriptionViewModel()

    var body: some View {
        
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                
                Text("Harish Garg")
                    .font(.title)
                    .padding(.vertical, 5)
                
                Text("4131 Dallyn Road, Richmond - British Columbia - Canada")
                    .lineLimit(5)
                
                Text("Phone Number: 7897656789")
                    .lineLimit(5)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(red: 150/255, green: 150/255, blue: 150/255, opacity: 0.2), lineWidth: 1)
                    .shadow(radius: 2)
            )
            .padding()
            
            Button {
                self.isConfirmed = true
                
            } label: {
                Text("Deliver to this address")
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .white))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.themeColor)
                            .shadow(color: .gray, radius: 2, x: 0, y: 2))
                    .padding()
            }
            .navigationDestination(isPresented: $isConfirmed) {
                CheckoutView(viewModel: self.viewModel)
            }
            
            Button {
                self.isEdit = true
                
            } label: {
                Text("Edit address")
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .theme))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(color: .gray, radius: 2, x: 0, y: 2))
                    .padding()
            }
            .sheet(isPresented: $isEdit, content: {
                AddressDetailView(headerTitle: "Shipping Address", addressDetail: nil)
            })
            
            Spacer()
            
        }
        .padding()
        .navigationBarTitle("Shipping Address",displayMode: .inline)
    .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    ConfirmAddressView(addresses: AddressViewModel())
}
