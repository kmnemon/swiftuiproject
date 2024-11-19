//
//  ContentView-ViewModel.swift
//  RecognizeWithDocument
//
//  Created by ke on 2024/11/6.
//

import Foundation

extension ContentView {
    @Observable
    class ViewModel {
        var persons = [Person]()
        let url = URL.documentsDirectory.appending(path: "persons.txt")

     
        func addPerson(person: Person) {
            persons.append(person)
            saveToFile()
        }
        
        init() {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                
                if let persons = try? decoder.decode([Person].self, from: data) {
                    self.persons = persons
                }
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
        func saveToFile() {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(persons){
                do {
                    try data.write(to: url, options: [.atomic, .completeFileProtection])
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
    }
}
