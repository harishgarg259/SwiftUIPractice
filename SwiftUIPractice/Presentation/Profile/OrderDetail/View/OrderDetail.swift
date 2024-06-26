//
//  OrderDetail.swift
//  Yappetizer
//
//  Created by Harish Garg on 16/02/24.
//

import SwiftUI

struct OrderDetail: View {
    
    var orderDetail: OrderList?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 5) {
                
                VStack(alignment: .leading, spacing: 8){
                    //Order #19648 was placed on April 29, 2022 and is currently Completed.
                    Text("Order Status:")
                        .fontWeight(.bold)
                    Text("Order #\(orderDetail?.id ?? 0) was placed on **\((orderDetail?.date_created ?? "").formatDate(date: "MMM d, yyyy"))** and is currently **\(orderDetail?.status ?? "").**")
                }
                .padding()
                Divider()
                
                VStack(alignment: .leading, spacing: 5){
                    Text("Order Items:")
                        .fontWeight(.bold)
                    ForEach(Array((orderDetail?.line_items ?? []).enumerated()), id: \.offset) { section, element in
                        HStack {
                            VStack(alignment: .leading){
                                Text(element.name ?? "")
                                Text("Quantity: \(element.quantity ?? 1)")
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            Spacer()
                            Text("$\(element.subtotal ?? "")")
                        }
                    }.padding(5)
                }
                .padding()
                
                Divider()
                
                // Summary Section
                VStack(alignment: .leading, spacing: 15) {
//                    HStack {
//                        Text("Subtotal:")
//                            .fontWeight(.bold)
//                        Spacer()
//                        Text(orderDetail?.subtotal ?? "")
//                    }
//                    Divider()
                    if let discount_total = orderDetail?.discount_total, !discount_total.isEmpty
                    {
                        HStack {
                            Text("Discount:")
                                .fontWeight(.bold)
                            Spacer()
                            Text("-$\(discount_total)")
                        }
                        Divider()
                    }
                    
                    
                    ForEach(Array((orderDetail?.shipping_lines ?? []).enumerated()), id: \.offset) { section, element in
                        HStack {
                            Text("Shipping:")
                                .fontWeight(.bold)
                            Spacer()
                            VStack(alignment: .trailing){
                                Text("$\(element.total ?? "")")
                                    .fontWeight(.semibold)
                                Text("(\(element.method_title ?? ""))")
                                    .font(.system(size: 12))
                            }
                        }
                        Divider()
                    }
                    
                    ForEach(Array((orderDetail?.tax_lines ?? []).enumerated()), id: \.offset) { section, element in
                        HStack {
                            Text("\(element.label ?? ""):")
                                .fontWeight(.bold)
                            Spacer()
                            Text("$\(element.tax_total ?? "")")
                        }
                        Divider()
                    }
                    
                    // Payment Method
                    HStack {
                        Text("Payment method:")
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(orderDetail?.payment_method_title ?? "")")
                    }
                }
                .padding()
                
                Divider()
                
                // Total
                HStack {
                    Text("Total:")
                        .fontWeight(.bold)
                    Spacer()
                    Text("\(orderDetail?.total ?? "")")
                }
                .padding()
                
                Divider()
                
                // Billing and Shipping Addresses
                HStack {
                    VStack(alignment: .leading) {
                        Text("Billing address:")
                            .fontWeight(.bold)
                        addressView(address: orderDetail?.billing)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Shipping address:")
                            .fontWeight(.bold)
                        addressView(address: orderDetail?.shipping)
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
    
    func addressView(address: Shipping?) -> some View{
        return VStack(alignment: .leading, spacing: 8) {
            
            if let first_name = address?.first_name, let last_name = address?.last_name, !first_name.isEmpty
            {
                Text("\(first_name) \(last_name)")
                    .font(.body)
            }
            if let address1 = address?.address_1, !address1.isEmpty
            {
                Text(address1)
                    .font(.body)
            }
            if let address2 = address?.address_2, !address2.isEmpty
            {
                Text(address2)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            if let city = address?.city, let postcode = address?.postcode, !city.isEmpty
            {
                Text("\(city), \(postcode)")
                    .font(.body)
            }
            if let country = address?.country, !country.isEmpty
            {
                Text(country)
                    .font(.footnote)
                    .italic()
            }
            if let phone = address?.phone, !phone.isEmpty
            {
                Text("\(phone)")
                    .font(.footnote)
                    .italic()
            }
            if let email = address?.email, !email.isEmpty
            {
                Text("\(email)")
                    .font(.footnote)
                    .italic()
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetail()
    }
}

