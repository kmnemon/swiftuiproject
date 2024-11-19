//
//  Expenses.swift
//  iExpense
//
//  Created by ke on 2024/10/25.
//

import SwiftUI
import SwiftData

@Model
class ExpenseItem: Identifiable {
    var id: UUID
    var name: String
    var type: String
    var price: Double
    
    init(name: String, type: String, price: Double) {
        self.id = UUID()
        self.name = name
        self.type = type
        self.price = price
    }
}
