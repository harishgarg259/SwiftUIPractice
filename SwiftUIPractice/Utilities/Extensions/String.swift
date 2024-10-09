//
//  String.swift
//  Yappetizer
//
//  Created by Harish Garg on 13/06/24.
//

import Foundation

extension String{
    
    /// Localized string for key.
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    static func random(length: Int = 20) -> String {
            let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            var randomString: String = ""

            for _ in 0..<length {
                let randomValue = arc4random_uniform(UInt32(base.count))
                randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
            }
            return randomString
    }
    
    static func decodeHTMLString(_ html: String) async -> String? {
        return await Task {
            await MainActor.run {
                return html.attributedHtmlString?.string
            }
        }.value
    }
    
    var attributedHtmlString: NSAttributedString? {
        try? NSAttributedString(
            data: Data(utf8),
            options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil
        )
    }
    
    func toDouble() -> Double? {
            return NumberFormatter().number(from: self)?.doubleValue
    }
}
