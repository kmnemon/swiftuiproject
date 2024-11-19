//
//  AddView.swift
//  iExpense
//
//  Created by Paul Hudson on 16/10/2023.
//

import SwiftUI

struct AddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var name = "Your Name"
    @State private var type = "Personal"
    @State private var price = 0.0
    
    let types = ["Personal", "Business"]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Price", value: $price, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, price: price)
                    modelContext.insert(item)
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
    AddView()
}
