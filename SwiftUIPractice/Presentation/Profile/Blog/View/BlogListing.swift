//
//  BlogListing.swift
//  Yappetizer
//
//  Created by Harish Garg on 25/06/24.
//

import SwiftUI

struct BlogListing: View {
        
    @StateObject var blogViewModel: BlogListViewModel = BlogListViewModel()
    
    var body: some View {
        List {
            ForEach(Array(blogViewModel.blogList.enumerated()), id: \.offset) { section, element in
                BlogRow(blogDetail: element)
            }
        }
        .navigationBarTitle("Blogs",displayMode: .inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .tint(.themeColor)
    }
    
}

#Preview {
    BlogListing()
}
