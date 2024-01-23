//
//  ImageRow.swift
//  UserDisplayApp-SwiftUI
//
//  Created by Harish garg on 20/01/24.
//

import SwiftUI

struct ImageRow: View {

    @State var imageDetail: Items?
    @State var mediaType: Media?

    var body: some View {
		HStack {
            AsyncImage(url: URL(string: filterData()?.href ?? "")) { image in
				image
					.resizable()
					.scaledToFit()
			} placeholder: {
				Color.gray.opacity(0.1)
			}
			.frame(width: 94)
            .padding(.top, 5)
			.padding(.leading, 10)
			.padding(.trailing, 10)

			VStack(alignment: .leading, spacing: 5) {
				Text("\(filterData()?.title ?? "")")
			}
			.padding(.horizontal, 8)

			Spacer()
		}
		.frame(height: 104)
    }
    
    //Check if links exist or not
    func filterData() -> Links?{
        guard let data = imageDetail?.filterLink(type: mediaType ?? .Image) else {
            return nil
        }
        return data
    }
    
    //Check if data exist or not
    func filterData() -> Details?{
        guard let data = imageDetail?.filterData(type: mediaType ?? .Image) else {
            return nil
        }
        return data
    }
    
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        ImageRow(imageDetail: Items(), mediaType: .Image)
    }
}
