//
//  Person.swift
//  RecognizeWithDocument
//
//  Created by ke on 2024/11/6.
//

import SwiftUI
import Foundation
import PhotosUI

@Observable
class Person: Identifiable, Codable, Comparable {
    var id: UUID
    var name: String
    var photoData: Data
    
    var photoImage: Image? {
        if let uiImage = UIImage(data: photoData) {
            return Image(uiImage: uiImage)
        }
        return nil
    }

    init(name: String, photo: Data) {
        self.id = UUID()
        self.name = name
        self.photoData = photo
    }
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
}
