//
//  Cards.swift
//  Flashzilla
//
//  Created by ke on 2024/11/11.
//

import SwiftUI

@Observable
class Cards {
    var items: [Card]
    
    func loadData() {
        let url = URL.documentsDirectory.appending(path: "cards.txt")
        
        do {
            let data = try Data(contentsOf: url)
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                items = decoded
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveData() {
        let url = URL.documentsDirectory.appending(path: "cards.txt")
        
        if let data = try? JSONEncoder().encode(items) {
            do {
                try data.write(to: url, options: [.atomic, .completeFileProtection])
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func loadDataByUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                items = decoded
            }
        }
    }
    
    func saveDataByUserDefaults() {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: "Cards")
        }
    }
    
    init(cards: [Card]) {
        self.items = cards
    }
}
