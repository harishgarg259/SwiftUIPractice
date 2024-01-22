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
                    VStack {
                        Image(systemName: "exclamationmark.icloud.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 64.0, height: 64.0)
                            .foregroundColor(.accentColor)
                        Text("Ooops, No users around!")
                            .font(.title2)
                            .foregroundColor(.red)
                    }
                } else {
                    List(viewModel.records, id: \.href) { user in
                        ImageRow(imageDetail: user, mediaType: viewModel.mediaType)
                    }
                    .navigationTitle("Contacts")
                    .toolbarColorScheme(.dark, for: .navigationBar)
                    .toolbarBackground(.automatic, for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                }
            }.onAppear {
                searchImages(for: "moon")
            }
        }
        .environmentObject(viewModel)
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
