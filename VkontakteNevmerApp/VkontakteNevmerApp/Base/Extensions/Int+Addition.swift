//
//  Int+Addition.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 11.10.2021.
//

import Foundation

extension Int {
    
    func formattedAge() -> String {
        var age = "лет"
        if self % 100 > 10 && self % 100 < 20 {
            age = "лет"
        }
        else if self % 10 == 1 {
            age = "год"
        }
        else if self % 10 > 1 && self % 10 < 5 {
            age = "года"
        }
        
        return "\(self) " + age
    }
}
