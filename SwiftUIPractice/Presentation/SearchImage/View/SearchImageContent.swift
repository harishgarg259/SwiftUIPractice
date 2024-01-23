//
//  SearchImageContent.swift
//  SwiftUIPractice
//
//  Created by Harish Garg on 11/01/24.
//

import SwiftUI

struct SearchImageContent: View {
    
    @StateObject var viewModel: SearchServiceViewModel
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $searchText, onTextChanged: searchImages)
                if viewModel.records.isEmpty {
                    showEmptyView(title: "No Images to display!", reason: .ImageNotFound)
                } else {
                    List(viewModel.records, id: \.href) { detail in
                        ImageRow(imageDetail: detail, mediaType: viewModel.mediaType)
                    }
                }
                Spacer()
            }
            .appBar(title: "Search Images") {
                debugPrint("button action callback")
            }
            .environmentObject(viewModel)
        }
    }
    
    func searchImages(for searchText: String) {
        if !searchText.isEmpty {
            viewModel.searchImages(searchString: searchText, page: 1)
        }
    }
}

struct SearchImageContent_Previews: PreviewProvider {
    static var previews: some View {
        SearchImageContent(viewModel: SearchServiceViewModel())
    }
}
