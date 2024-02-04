//
//  SearchImageContent.swift
//  SwiftUIPractice
//
//  Created by Harish Garg on 11/01/24.
//

import SwiftUI

struct SearchImageContent: View {
    
    @Binding var showMenu: Bool
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
                    .listStyle(PlainListStyle())
                    .background(.white)
                    .scrollContentBackground(.hidden)
                    .scrollDismissesKeyboard(.interactively)
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
        }else{
            viewModel.records.removeAll()
        }
    }
}

//struct SearchImageContent_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchImageContent(showMenu: false, viewModel: SearchServiceViewModel())
//    }
//}
