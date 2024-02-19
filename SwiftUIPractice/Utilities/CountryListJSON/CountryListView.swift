//
//  CountryListView.swift
//  Yappetizer
//
//  Created by Harish Garg on 18/02/24.
//

import SwiftUI

struct CountryListView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var countries = CountriesData()
    var selectedCountry: ((Any) -> Void)?
    var pickerType: CountryPicker = .Country
    var states: [States] = []
    
    var body: some View {
        
        VStack {
            if pickerType == .Country{
                List(countries.countries , id: \.name){ countryInfo in
                    HStack {
                        Text(countryInfo.name ?? "")
                            .font(.system(size: 14,weight: .medium))
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .onTapGesture {
                        selectedCountry?(countryInfo)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }else{
                List(states , id: \.name){ stateInfo in
                    HStack {
                        Text(stateInfo.name ?? "")
                            .font(.system(size: 14,weight: .medium))
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .onTapGesture {
                        selectedCountry?(stateInfo)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .navigationTitle("Select Country")
        .navigationBarBackButtonHidden(false)
        .toolbar {
            Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

#if DEBUG
#Preview {
    CountryListView()
}
#endif


