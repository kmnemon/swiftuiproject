//
//  Book.swift
//  Bookworm
//
//  Created by Paul Hudson on 17/11/2023.
//

import Foundation
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var date: Date
    
    init(title: String, author: String, genre: String, review: String, rating: Int, date: Date) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.date = date
    }
    
    convenience init(title: String, author: String, genre: String, review: String, rating: Int) {
        self.init(title: title, author: author, genre: genre, review: review, rating: rating, date: .now)
    }
    
}
