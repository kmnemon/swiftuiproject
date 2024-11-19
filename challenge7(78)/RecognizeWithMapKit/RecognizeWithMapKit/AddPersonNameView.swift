//
//  AddPersonNameView.swift
//  RecognizeWithMapKit
//
//  Created by ke on 2024/11/6.
//

import SwiftUI

struct AddPersonNameView: View {
    @Environment(\.dismiss) var dismiss

    var person: Person
    let locationFetcher = LocationFetcher()
    
    @State private var name: String
    var onSave: (Person) -> Void
 
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Enter the name", text: $name)
                }
            }
            .navigationTitle("Add Person Name")
            .toolbar {
                Button("save") {
                    person.name = name
                    
                    if let location = locationFetcher.lastKnownLocation {
                        person.latitude = location.latitude
                        person.longitude = location.longitude
                    }
   
                    onSave(person)
                    dismiss()
                }
            }
        }
    }
    
    init(person: Person, onSave: @escaping (Person) -> Void) {
        self.person = person
        self.name = person.name
        self.onSave = onSave
        
        locationFetcher.start()
    }
}
