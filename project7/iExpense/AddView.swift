//
//  AddView.swift
//  iExpense
//
//  Created by Paul Hudson on 16/10/2023.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss

    @State private var name = "Your Name"
    @State private var type = "Personal"
    @State private var amount = 0.0

    var expenses: Expenses

    let types = ["Business", "Personal"]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    if item.type == "Personal" {
                        expenses.personalItems.append(item)
                    } else if item.type == "Business" {
                        expenses.businessItems.append(item)
                    }
                    
                    if let encoded = try? JSONEncoder().encode(expenses) {
                        UserDefaults.standard.set(encoded, forKey: "Expenses")
                    }
                    
                    dismiss()
                }
                
                Button("Cancel") {
                    dismiss()
                }
            }
            .navigationBarBackButtonHidden()
            
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
