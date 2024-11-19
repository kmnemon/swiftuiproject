//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by ke on 2024/11/14.
//

import SwiftUI
import CoreData

struct FilteredGenericList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content ) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K", filterKey, filterValue))
        
        self.content = content
    }
}
