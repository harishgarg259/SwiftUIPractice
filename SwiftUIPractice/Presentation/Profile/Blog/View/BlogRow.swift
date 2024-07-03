//
//  BlogRow.swift
//  UserDisplayApp-SwiftUI
//
//  Created by Harish garg on 25/06/24.
//

import SwiftUI

struct BlogRow: View {
    let blogDetail: BlogBaseModel?
    
    var body: some View {
        NavigationLink(destination: BlogDetailView(blogDetail: blogDetail)) {
            VStack(alignment: .leading, spacing: 10) {
                
                Text(blogDetail?.yoast_head_json?.title ?? "")
                    .font(.system(size: 14,weight: .semibold))
                    .lineLimit(4)
            }
            .padding([.top,.bottom],8)
            .background(.white)
        }
    }
}

struct BlogRow_Previews: PreviewProvider {
    static var previews: some View {
        BlogRow(blogDetail: nil)
    }
}
