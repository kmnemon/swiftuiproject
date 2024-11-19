//
//  Person.swift
//  RecognizeWithMapKit
//
//  Created by ke on 2024/11/6.
//

import SwiftUI
import SwiftData
import Foundation
import PhotosUI

@Model
class Person: Identifiable, Codable, Comparable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case photoData = "photoData"
        case latitude = "latitude"
        case longitude = "longitude"
    }
    
    var id: UUID
    var name: String
    @Attribute(.externalStorage) var photoData: Data
    var latitude: Double
    var longitude: Double
    
    var photoImage: Image? {
        if let uiImage = UIImage(data: photoData) {
            return Image(uiImage: uiImage)
        }
        return nil
    }

    init(name: String, photo: Data, latitude: Double, longitude: Double) {
        self.id = UUID()
        self.name = name
        self.photoData = photo
        self.latitude = latitude
        self.longitude = longitude
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.photoData = try container.decode(Data.self, forKey: .photoData)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)

    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.photoData, forKey: .photoData)
        try container.encode(self.latitude, forKey: .latitude)
        try container.encode(self.longitude, forKey: .longitude)
    }
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
}
