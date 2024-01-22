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
					.scaledToFill()
			} placeholder: {
				Color.gray.opacity(0.1)
			}
			.frame(width: 104)
			.padding(-10)
			.padding(.leading, -8)
			.padding(.trailing, 12)

			VStack(alignment: .leading, spacing: 5) {
				Text("\(filterData()?.title ?? "")")
			}
			.padding(.horizontal, 8)

			Spacer()

			Circle()
				.frame(maxWidth: 15, maxHeight: 15)
				.foregroundColor(Color(red: 0, green: 202/255, blue: 167/255))
				.padding()
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
