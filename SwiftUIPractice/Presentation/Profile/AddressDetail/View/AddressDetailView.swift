//
//  AddressDetailView.swift
//  Yappetizer
//
//  Created by Harish Garg on 16/02/24.
//

import SwiftUI

struct AddressDetailView: View {
    

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var companyName = ""
    @State private var countryText = ""
    @State private var stateText = ""
    @State private var streetAddress = ""
    @State private var apartmentName = ""
    @State private var town = ""
    @State private var postcode = ""
    @State private var presented = false
    @State private var isPresented = false
    @StateObject private var alert = AlertContext()
    var addressDetailViewModel = AddressDetailViewModel()
    var addressDetail: AddressGroup?
    var headerTitle: String = ""

    init(headerTitle: String,addressDetail: AddressGroup?){
        self.headerTitle = headerTitle
        self.addressDetail = addressDetail
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 15, content: {
                YPTextField(text: $firstName)
                    .setTitleText("First name*")
                    .setPlaceHolderText("First name")
                YPTextField(text: $lastName)
                    .setTitleText("Last Name*")
                    .setPlaceHolderText("Last Name")
                YPTextField(text: $companyName)
                    .setTitleText("Company Name")
                    .setPlaceHolderText("Company Name")
                YPTextField(text: $countryText)
                    .setTitleText("Country / Region*")
                    .setPlaceHolderText("Select Country")
                    .setTrailingImage(Image("down"), click: {
                        self.presented = true
                    })
                    .sheet(isPresented: $presented) {
                        CountryListView(selectedCountry: updateCountryName, pickerType: .Country)
                    }
                YPTextField(text: $stateText)
                    .setTitleText("Province/State*")
                    .setPlaceHolderText("Select Province")
                    .setTrailingImage(Image("down"), click: {
                        if self.addressDetailViewModel.states.isEmpty{
                            alert.present(Alert(title: Text(""), message: Text("Please select country.")))
                        }else{
                            self.isPresented = true
                        }
                    })
                    .alert(alert)
                    .sheet(isPresented: $isPresented) {
                        CountryListView(selectedCountry: updateCountryName, pickerType: .State, states: self.addressDetailViewModel.states)
                    }
                
                YPTextField(text: $streetAddress)
                    .setTitleText("Street address*")
                    .setPlaceHolderText("Street address")
                YPTextField(text: $apartmentName)
                    .setPlaceHolderText("Apartment, suite, unit etc")
                YPTextField(text: $town)
                    .setTitleText("Town / City*")
                    .setPlaceHolderText("Town / City")
                YPTextField(text: $postcode)
                    .setTitleText("Postcode / ZIP*")
                    .setPlaceHolderText("Postcode / ZIP")
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
                .disabled(firstName.isEmpty || lastName.isEmpty || countryText.isEmpty || stateText.isEmpty || streetAddress.isEmpty || town.isEmpty || postcode.isEmpty)
                Spacer()
            })
            .padding()
            .tint(.themeColor)
        }
        .onAppear(perform: {
            self.updateFieldValues()
        })
        .navigationBarTitle(headerTitle,displayMode: .inline)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    private func updateCountryName(selectedRow: Any){
        
        if let selectedRow = selectedRow as? Country {
            self.countryText = selectedRow.name ?? ""
            self.addressDetailViewModel.states = selectedRow.states ?? []
            self.stateText = ""
        }else if let selectedRow = selectedRow as? States {
            self.stateText = selectedRow.name ?? ""
        }
        
    }
    
    private func updateFieldValues(){
        
        guard let address = self.addressDetail?.address[0].addressDetail else { return }
        self.firstName = address.first_name ?? ""
        self.lastName = address.last_name ?? ""
        self.companyName = address.company ?? ""
        self.countryText = address.country ?? ""
        self.stateText = address.state ?? ""
        self.streetAddress = address.address_1 ?? ""
        self.apartmentName = address.address_2 ?? ""
        self.town = address.city ?? ""
        self.postcode = address.postcode ?? ""

    }
    
}

#Preview {
    AddressDetailView(headerTitle: "", addressDetail: nil)
}
