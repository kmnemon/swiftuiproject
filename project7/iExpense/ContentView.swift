//
//  ContentView.swift
//  iExpense
//
//  Created by Paul Hudson on 15/10/2023.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses: Codable {
    var personalItems = [ExpenseItem]()
    var businessItems = [ExpenseItem]()
    //    {
    //        didSet {
    //            if let encoded = try? JSONEncoder().encode(items) {
    //                UserDefaults.standard.set(encoded, forKey: "PersonalItems")
    //            }
    //        }
    //    }
    
    //    init() {
    //        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
    //            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
    //                items = decodedItems
    //                return
    //            }
    //        }
    
    //        items = []
    //    }
}

struct MoneyStyle: ViewModifier{
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(color)
        
    }
}

extension View{
    func moneyStyle(at amount: Double) -> some View{
        if amount < 10 {
            modifier(MoneyStyle(color: .green))
        } else if amount < 100 {
            modifier(MoneyStyle(color: .blue))
        } else {
            modifier(MoneyStyle(color: .red))
        }
    }
}


struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Personal") {
                    ForEach(expenses.personalItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .moneyStyle(at: item.amount)
                        }
                        .accessibilityElement()
                        .accessibilityLabel("Name is \(item.name) and Value is \(item.amount)")
                        .accessibilityHint("Type is \(item.type)")
                    }
                    .onDelete(perform: removePersonItems)
                }
                
                Section("Business") {
                    ForEach(expenses.businessItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .moneyStyle(at: item.amount)
                        }
                        .accessibilityElement()
                        .accessibilityLabel("Name is \(item.name) and Value is \(item.amount)")
                        .accessibilityHint("Type is \(item.type)")
                    }
                    .onDelete(perform: removeBusinessItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense(sheet)", systemImage: "plus") {
                    showingAddExpense = true
                }
                
                NavigationLink("Add Expense(link)") {
                    AddView(expenses: expenses)
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
        .onAppear(perform: initExpenses)
    }
    
    func initExpenses() {
        if let savedExpenses = UserDefaults.standard.data(forKey: "Expenses") {
            if let decodedExpenses = try? JSONDecoder().decode(Expenses.self, from: savedExpenses) {
                expenses = decodedExpenses
                return
            }
        }
    }
    
    func removePersonItems(at offsets: IndexSet) {
        expenses.personalItems.remove(atOffsets: offsets)
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        expenses.businessItems.remove(atOffsets: offsets)
    }
}




#Preview {
    ContentView()
}
