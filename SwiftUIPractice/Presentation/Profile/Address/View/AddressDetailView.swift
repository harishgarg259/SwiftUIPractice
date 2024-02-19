//
//  AddressDetailView.swift
//  Yappetizer
//
//  Created by Harish Garg on 16/02/24.
//

import SwiftUI

struct AddressDetailView: View {
    
    var headerTitle: String
    @State private var text = ""
    @State private var countryText = ""
    @State private var stateText = ""
    @State private var presented = false
    @State private var isPresented = false
    private var states: [States] = []

    var body: some View {
        ScrollView {
            VStack {
                YPTextField(text: $text)
                    .setTitleText("First name")
                YPTextField(text: $text)
                    .setTitleText("Last Name")
                YPTextField(text: $text)
                    .setTitleText("Company Name")
                YPTextField(text: $countryText)
                    .setTitleText("Country / Region")
                    .setTrailingImage(Image(systemName: "arrowtriangle.down"), click: {
                        self.presented = true
                    })
                    .sheet(isPresented: $presented) {
                        CountryListView(selectedCountry: updateCountryName, pickerType: .Country)
                    }
                YPTextField(text: $stateText)
                    .setTitleText("Province/State")
                    .setTrailingImage(Image(systemName: "arrowtriangle.down"), click: {
                        self.isPresented = true
                    })
                    .sheet(isPresented: $isPresented) {
                        CountryListView(selectedCountry: updateCountryName, pickerType: .State, states: self.states)
                    }
                
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
    
    mutating private func updateCountryName(selectedRow: Any){
        
        if let selectedRow = selectedRow as? Country {
            self.countryText = selectedRow.name ?? ""
            self.states = selectedRow.states ?? []
        }else if let selectedRow = selectedRow as? States {
            self.stateText = selectedRow.name ?? ""
        }
        
    }
    
}

#Preview {
    AddressDetailView(headerTitle: "")
}
