//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Paul Hudson on 15/10/2023.
//

import SwiftUI
import SwiftData

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
