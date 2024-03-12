//
//  OrderDetail.swift
//  Yappetizer
//
//  Created by Harish Garg on 16/02/24.
//

import SwiftUI

struct OrderDetail: View {
    
    var orderTitle: String = "Detail"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Yappetizers Wild Salmon Dog Treats - Bulk (1 kilogram)")
                        Text("Size: Bulk (1 kilogram)")
                            .fontWeight(.bold)
                    }
                    Spacer()
                    Text("$70.00")
                }
                .padding()
                
                Divider()
                
                // Summary Section
                VStack(alignment: .leading) {
                    HStack {
                        Text("Subtotal:")
                            .fontWeight(.bold)
                        Spacer()
                        Text("$70.00")
                    }
                    HStack {
                        Text("Discount:")
                            .fontWeight(.bold)
                        Spacer()
                        Text("-$10.50")
                    }
                    HStack {
                        Text("Shipping:")
                            .fontWeight(.bold)
                        Spacer()
                        Text("Free Shipping on order over $40.00 (Pre-tax amount)")
                    }
                    HStack {
                        Text("HST:")
                            .fontWeight(.bold)
                        Spacer()
                        Text("$7.74")
                    }
                    Divider()
                    HStack {
                        Text("Total:")
                            .fontWeight(.bold)
                        Spacer()
                        Text("$67.24")
                    }
                }
                .padding()
                
                Divider()
                
                // Payment Method
                HStack {
                    Text("Payment method:")
                        .fontWeight(.bold)
                    Spacer()
                    Text("Credit Card (Stripe)")
                }
                .padding()
                
                Divider()
                
                // Billing and Shipping Addresses
                HStack {
                    VStack(alignment: .leading) {
                        Text("Billing address")
                            .fontWeight(.bold)
                        Text("Yappetizers")
                        Text("Lesa Babak")
                        Text("39 Westgate Park Drive")
                        Text("St. Catharines ON L2N 5W8")
                        Text("604-710-0522")
                        Text("sean@yappetizers.com")
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Shipping address")
                            .fontWeight(.bold)
                        Text("Yappetizers")
                        Text("Lesa Babak")
                        Text("39 Westgate Park Drive")
                        Text("St. Catharines ON L2N 5W8")
                    }
                }
                .padding()
                
                Divider()
                
                // Order Again Button
                ZStack {
                    Button {
                    } label: {
                        Text("Order Again")
                            .frame(maxWidth: .infinity)
                            .fontWeight(.bold)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .shadow(color: .themeColor,radius: 2)
                    .padding(.top, 10)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                }
                .tint(.themeColor)
            }
        }
        .navigationBarTitle("Invoice",displayMode: .inline)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetail()
    }
}

