//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Paul Hudson on 14/12/2021.
//

import SwiftUI
import SwiftData

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
