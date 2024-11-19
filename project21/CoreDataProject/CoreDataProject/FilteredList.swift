//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by ke on 2024/11/14.
//

import SwiftUI

struct FilteredList: View {
    @FetchRequest var fetchRequest: FetchedResults<Movie>
    
    
    var body: some View {
        List(fetchRequest, id: \.self) { movie in
            Text("\(movie.wrappedTitle) and \(movie.wrappedDirector)")
        }
    }
    
    init(filter: String) {
        _fetchRequest = FetchRequest<Movie>(sortDescriptors: [], predicate: NSPredicate(format: "title BEGINSWITH %@", filter))
    }
}
