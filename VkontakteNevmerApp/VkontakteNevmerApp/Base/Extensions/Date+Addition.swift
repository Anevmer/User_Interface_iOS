//
//  Date+Addition.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 11.10.2021.
//

import Foundation

extension Date {
    
    // MARK: Public properties
    
    var currentYear: String {
        return getDateComponent(dateFormat: "yyyy")
    }
    var currentMonth: String {
        return getDateComponent(dateFormat: "M")
    }
    var currentDay: String {
        return getDateComponent(dateFormat: "d")
    }
    
    var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
    
    // MARK: Private methods
    
    private func getDateComponent(dateFormat: String) -> String {
        let format = DateFormatter()
        format.dateFormat = dateFormat
        return format.string(from: self)
    }
    
    // MARK: Public methods
    
}


