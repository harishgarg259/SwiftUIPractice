//
//  ImageViewExtension.swift
//  Yappetizer
//
//  Created by Harish Garg on 03/02/24.
//

import SwiftUI

extension View {
    public func ImageView(url: String) -> some View {
        
        AsyncImage(url: URL(string: url )) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            case .failure:
                Image(systemName: "photo")
            @unknown default:
                // Since the AsyncImagePhase enum isn't frozen,
                // we need to add this currently unused fallback
                // to handle any new cases that might be added
                // in the future:
                EmptyView()
            }
        }
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
