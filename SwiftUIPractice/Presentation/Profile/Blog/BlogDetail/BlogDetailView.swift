//
//  BlogDetailView.swift
//  Yappetizer
//
//  Created by Harish Garg on 25/06/24.
//

import SwiftUI
import WebKit

struct BlogDetailView: View {
    
    let blogDetail: BlogBaseModel?
    @State private var selectedSizeIndex = 0
    @State private var quantity = 1
//    @Binding var badgeCount : Int

    // 1. Number of items will be display in row
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible()),
    ]
    // 2. Fixed height of card
    let height: CGFloat = 200
    // 3. Get mock cards data
    let cards: [String] = ["Kangroo","Venison","Kangroo","Venison"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                
                // Multiple images in grid view with pagination view
                if let images = blogDetail?.yoast_head_json?.og_image{
                    BlogImageGrid(images: images)
                        .frame(height: 200) // Set your preferred height
                }
                
                // Product description with multiple headings and details
                VStack(alignment: .leading, spacing: 10) {
                    Text(blogDetail?.yoast_head_json?.title ?? "")
                        .font(.headline)
                    Text("by marylinregister | Jun 8, 2024 | Blog")
                        .foregroundStyle(Color(.gray))
                        .italic()
                    if let html = blogDetail?.content?.rendered {
                        if let nsAttributedString = try? NSAttributedString(data: Data(html.utf8), options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil),
                                   let attributedString = try? AttributedString(nsAttributedString, including: \.uiKit) {
                                    Text(attributedString)
                                } else {
                                    // fallback...
                                    Text(html)
                                }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Blog Detail")
    }
}

struct BlogImageGrid: View {
    let images: [OgImage]
    @State private var currentPage = 0
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(Array(images.enumerated()), id: \.offset) { section, element in
                    if let imageURL = element.url {
                        ImageView(url: imageURL)
                            .scaledToFit()
                            .tag(element.url)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .onAppear {
                setupAppearance()
            }
        }
    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
}


struct BlogDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BlogDetailView(blogDetail: nil)
        }
    }
}
