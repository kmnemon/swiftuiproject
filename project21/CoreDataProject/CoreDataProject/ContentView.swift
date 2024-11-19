//
//  ContentView.swift
//  CoreDataProject
//
//  Created by ke on 11/14/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "title == %@", "Harry Potter")) var movies: FetchedResults<Movie>
                                                                    // "title IN %@", ["aa","bb"]
                                                                    // "title BEGINSWITH %@", "H"]
                                                                    // "title NOT BEGINSWITH[c] %@", "H"]
                                                                    // "title CONTAINS[c] %@", "H"]
                                                                    // "title == 'Harry Potter'"
    
    @State private var titleFilter = "A"
    
    
    var body: some View {
        VStack {
            FilteredGenericList(filterKey: "title", filterValue: titleFilter) { (movie: Movie) in
                Text("\(movie.wrappedTitle)")
            }
            
            
            Button("Add Example") {
                let movie = Movie(context: moc)
                movie.title = "Harry Potter"
                movie.director = "Molly"
                
                let movie2 = Movie(context: moc)
                movie2.title = "Toy Story"
                movie2.director = "Pillix"
                
                let movie3 = Movie(context: moc)
                movie3.title = "The Ghost"
                movie3.director = "smith"
                
                try? moc.save()
            }
            
            Button("Show A") {
                titleFilter = "A"
            }
            
            Button("Show S") {
                titleFilter = "S"
            }
        }
        
        //constrain
        VStack {
            List(movies, id: \.self) { movie in
                Text(movie.title ?? "Unknown")
            }
        }
        
        Button("Add") {
            let movie = Movie(context: moc)
            movie.title = "Harry Potter"
            movie.director = "Molly"
        }
        
        Button("Save") {
            // moc save before check there is a change
            if moc.hasChanges {
                do {
                    try moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
}

#Preview {
    ContentView()
}
