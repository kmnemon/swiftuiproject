//
//  Friend.swift
//  Friends
//
//  Created by ke on 11/1/24.
//

import Foundation

struct User: Codable, Identifiable {
    struct Friend: Codable, Identifiable {
        let id: UUID
        let name: String
    }
    
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}
