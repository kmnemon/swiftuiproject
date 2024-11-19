//
//  RecognizeWithMapKitApp.swift
//  RecognizeWithMapKit
//
//  Created by ke on 11/6/24.
//

import SwiftUI
import SwiftData

@main
struct RecognizeWithMapKitApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Person.self)
    }
}
