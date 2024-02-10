//
//  Enum.swift
//  SwiftUIPractice
//
//  Created by Harish Garg on 05/02/24.
//

import Foundation

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

public enum SafariURL: String{
    case Blog
    case AboutUS
    case ContactUS
    case None

    var url: String {
        get {
            switch self {
            case .Blog:
                return AppConstants.blogURL
            case .AboutUS:
                return AppConstants.aboutUsURL
            case .ContactUS:
                return AppConstants.contactUsURL
            case .None:
                return ""
            }
        }
    }
}
