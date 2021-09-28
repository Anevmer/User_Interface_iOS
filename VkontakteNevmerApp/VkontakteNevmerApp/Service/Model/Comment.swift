//
//  Comment.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 08.09.2021.
//

import Foundation

class Comment {
    
    var text: String
    var authorId: Int
    var commentDate: Date
    
    init(text: String, authorId: Int) {
        self.text = text
        self.authorId = authorId
        self.commentDate = Date()
    }
}
