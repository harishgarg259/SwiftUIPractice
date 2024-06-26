//
//  Date.swift
//  Yappetizer
//
//  Created by Harish Garg on 24/06/24.
//

import Foundation


extension String{
    func formatDate(date: String) -> String {
       let dateFormatterGet = DateFormatter()
       dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

       let dateFormatter = DateFormatter()
       dateFormatter.dateStyle = .medium
       dateFormatter.timeStyle = .none
       let dateObj: Date? = dateFormatterGet.date(from: self)
        
        guard let date = dateObj else {
            return self
        }
       return dateFormatter.string(from: date)
    }
}


