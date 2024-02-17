//
//  AddressDetailView.swift
//  Yappetizer
//
//  Created by Harish Garg on 16/02/24.
//

import SwiftUI

struct AddressDetailView: View {
    
    var headerTitle: String
    @State var text = ""
    
    var body: some View {
        ScrollView {
            VStack {
                YPTextField(text: $text)
                    .setTitleText("First name")
                YPTextField(text: $text)
                    .setTitleText("Last Name")
                YPTextField(text: $text)
                    .setTitleText("Company Name")
                YPTextField(text: $text)
                    .setTitleText("Country / Region")
                    .setTrailingImage(Image(systemName: "arrowtriangle.down"), click: {
                        print("qr image tapped")
                    })
                YPTextField(text: $text)
                    .setTitleText("Province/State")
                    .setTrailingImage(Image(systemName: "arrowtriangle.down"), click: {
                        print("qr image tapped")
                    })
                
                YPTextField(text: $text)
                    .setTitleText("Street address")
                    .setPlaceHolderText("House number and street name")
                YPTextField(text: $text)
                    .setPlaceHolderText("Apartment, suite, unit etc")
                
                YPTextField(text: $text)
                    .setTitleText("Town / City")
                YPTextField(text: $text)
                    .setTitleText("Postcode / ZIP")
                    .padding(.bottom,20)
                
                Button {
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .shadow(color: .themeColor,radius: 2)
                .padding(.top, 10)
                .disabled(text.isEmpty)
                Spacer()
            }
            .padding()
            .navigationTitle(headerTitle)
            .navigationBarTitleDisplayMode(.inline)
            .tint(.themeColor)
        }
    }
    
}

#Preview {
    AddressDetailView(headerTitle: "")
}
