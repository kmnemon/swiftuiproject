//
//  CoreDataProjectWithRSApp.swift
//  CoreDataProjectWithRS
//
//  Created by ke on 2024/11/14.
//

import SwiftUI

@main
struct CoreDataProjectWithRSApp: App {
    let persistenceController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
