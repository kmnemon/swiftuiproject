//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by ke on 11/14/24.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    let persistenceController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
