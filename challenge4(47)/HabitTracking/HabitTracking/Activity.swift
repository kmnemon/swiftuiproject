//
//  HabitModel.swift
//  HabitTracking
//
//  Created by ke on 10/19/24.
//

import SwiftUI

struct Activity: Identifiable, Equatable, Codable {
    let id: UUID
    var title: String
    let description: String
    var completionCount: Int = 0
}

@Observable
class Activities {
    var activities: [Activity] = [] {
        didSet {
            save()
        }
    }
    
    func save() {
        let encode = JSONEncoder()
        if let data = try? encode.encode(activities) {
            UserDefaults.standard.set(data, forKey: "activities")
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "activities") {
            let decode = JSONDecoder()
            if let activities = try? decode.decode([Activity].self, from: data) {
                self.activities = activities
            }
        }
    }
}
