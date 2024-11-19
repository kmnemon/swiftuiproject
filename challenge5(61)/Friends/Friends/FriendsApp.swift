//
//  FriendsApp.swift
//  Friends
//
//  Created by ke on 11/1/24.
//

import SwiftUI
import SwiftData

@main
struct FriendsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [User.self, Friend.self])
    }
}
