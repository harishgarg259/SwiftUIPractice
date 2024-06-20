//
//  DetailView.swift
//  Yappetizer
//
//  Created by Harish Garg on 22/01/24.
//

import SwiftUI

struct CartItem: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let price: String
    let color: String
    let size: String
}

struct CartView: View {
    // Sample data for cart items
    let cartItems = [
        CartItem(image: "pork-liver", title: "2018 Hot Sale Spring Autumn...", price: "US $25.68", color: "gray", size: "XL"),
        CartItem(image: "pork-liver", title: "2018 Sale Blue Jackets", price: "US $20.25", color: "gray", size: "XL"),
        CartItem(image: "pork-liver", title: "2018 Sale Green Jackets", price: "US $32.89", color: "gray", size: "XL")
    ]
    @State private var isConfirmed = false

    @Binding var showMenu: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: 5, content: {
                    ForEach(cartItems) { item in
                        HStack {
                            Image(item.image)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(5)
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.headline)
                                Text(item.price)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Button("REMOVE") {}
                        }
                    }
                
                // Price Details Section
                VStack(alignment: .leading) {
                    Text("Price Details")
                        .fontWeight(.bold)
                    HStack {
                        Text("Sub Total")
                        Spacer()
                        Text("$75.61")
                    }
                    HStack {
                        Text("Discount")
                        Spacer()
                        Text("-$10.61")
                    }
                    HStack {
                        Text("Estimated Tax")
                        Spacer()
                        Text("$2.61")
                    }
                    HStack {
                        Text("Delivery")
                        Spacer()
                        Text("FREE")
                            .foregroundColor(.green)
                    }
                }
                .padding()
                
                Divider()
                
                // Total Payable Section
                HStack {
                    Text("Total Payable")
                        .fontWeight(.bold)
                    Spacer()
                    Text("$67.61")
                        .foregroundColor(.blue)
                }
                .padding()
                
                // Buttons for Cancel and Next
                HStack {
                    Button("CANCEL") {
                        // Cancel action
                    }
                    .foregroundColor(.red)
                    
                    Spacer()
                    
                    Button("NEXT") {
                        self.isConfirmed = true
                    }
                    .foregroundColor(.blue)
                    .navigationDestination(isPresented: $isConfirmed) {
                        ConfirmAddressView()
                    }
                }
                .padding()
            })
        }
        .navigationBarTitle(Text("Cart"), displayMode: .inline)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(showMenu: .constant(true))
    }
}
