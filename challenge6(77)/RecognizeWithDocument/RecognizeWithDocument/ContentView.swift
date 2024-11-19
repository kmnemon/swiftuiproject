//
//  ContentView.swift
//  RecognizeWithDocument
//
//  Created by ke on 2024/11/6.
//

import SwiftUI
import PhotosUI
import CoreImage


struct ContentView: View {    
    @State private var viewModel = ViewModel()
    
    @State private var pickerItem: PhotosPickerItem?
    
    @State private var person: Person?
    
    
    var body: some View {
        NavigationStack {
            List(viewModel.persons.sorted()) { person in
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
                        person = Person(name: "", photo: data)
                    }
                }
            }
            .sheet(item: $person) { p in
                AddPersonNameView(person: p) { person in
                    viewModel.addPerson(person: person)
                }
            }
        }
    }
    
 
}

#Preview {
    ContentView()
}
