//
//  EmptyView.swift
//  SwiftUIPractice
//
//  Created by Harish Garg on 22/01/24.
//

import SwiftUI

public enum EmptyScreenEnum: String{
    case ImageNotFound
    case EmptyView
    
    var media: String {
        get {
            switch self {
            case .ImageNotFound:
                return "image"
            case .EmptyView:
                return "video"
            }
        }
    }
}

extension View {
    /// CommonAppBar
    public func showEmptyView(title: String, reason: EmptyScreenEnum) -> some View {
        VStack {
            Image(systemName: "exclamationmark.icloud.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 64.0, height: 64.0)
                .foregroundColor(.accentColor)
            Text(title)
                .font(.title2)
                .foregroundColor(.red)
        }
    }
}
