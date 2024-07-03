//
//  FetchState.swift
//  ItunesSearchApp
//
//  Created by Karin Prater on 25.07.22.
//

import Foundation

enum FetchState: Comparable {
    case idle
    case isLoading
    case loadedAllProducts
    case error(String)
}
