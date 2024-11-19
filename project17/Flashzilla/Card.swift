//
//  Card.swift
//  Flashzilla
//
//  Created by Paul Hudson on 09/01/2022.
//

import Foundation


struct Card: Codable, Identifiable, Equatable {
    let id: UUID
    let prompt: String
    let answer: String
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        if lhs.id != rhs.id { return false }
        return true
    }

    static let example = Card(id: UUID(), prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
