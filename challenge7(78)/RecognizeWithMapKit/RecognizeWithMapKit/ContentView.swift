//
//  ContentView.swift
//  RecognizeWithMapKit
//
//  Created by ke on 11/6/24.
//

import SwiftUI
import SwiftData
import PhotosUI
import CoreImage

struct ContentView: View {
    @Environment(\.modelContext) var modelContent
    @Query(sort: \Person.name) var persons: [Person]
    
    @State private var pickerItem: PhotosPickerItem?
    
    @State private var person: Person?
    
    
    var body: some View {
        NavigationStack {
            List(persons) { person in
                NavigationLink {
                    DetaiView(person: person)
                } label: {
                    HStack {
                        person.photoImage?
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        
                        Spacer()
                        
                        Text(person.name)
                    }
                }
            }
            
            Spacer()
            
            VStack {
                PhotosPicker(selection: $pickerItem, matching: .images) {
                    Label("Select a photo", systemImage: "photo")
                }
            }
            .onChange(of: pickerItem) {
                Task {
                    let imageData = try await pickerItem?.loadTransferable(type: Data.self)
                    
                    if let data = imageData {
                        person = Person(name: "", photo: data, latitude: 0.0, longitude: 0.0)
                    }
                }
            }
            .sheet(item: $person) { p in
                AddPersonNameView(person: p) { person in
                    modelContent.insert(person)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
