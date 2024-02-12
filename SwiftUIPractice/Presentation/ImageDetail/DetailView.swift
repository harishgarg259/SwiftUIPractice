//
//  DetailView.swift
//  Yappetizer
//
//  Created by Harish Garg on 22/01/24.
//

import SwiftUI

struct DetailView: View {
    
    @State var detail: Items?

    var body: some View {
        VStack {
            ImageView(url: filterData()?.href ?? "")
                .frame(height: 250.0)
            Text(detail?.filterData(type: .Image)?.description ?? "")
                .padding()
            Spacer()
        }
        .navigationTitle("Image Detail")
    }
    
    //Check if links exist or not
    func filterData() -> Links?{
        guard let data = detail?.filterLink(type: .Image) else {
            return nil
        }
        return data
    }
}

#Preview {
    DetailView(detail: Items())
}
