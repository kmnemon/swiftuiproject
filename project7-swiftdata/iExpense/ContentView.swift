//
//  ContentView.swift
//  iExpense
//
//  Created by Paul Hudson on 15/10/2023.
//

import SwiftUI
import SwiftData

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
    @Environment(\.modelContext) var modelContext
    @State private var showingUsers = "All"
    
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.type)
    ]
            
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            ExpenseItemView(showingUsers: showingUsers, sortOrder: sortOrder)
            .navigationTitle("iExpense")
            .toolbar {
//                Button("Add Expense(sheet)", systemImage: "plus") {
//                    showingAddExpense = true
//                }
                
                NavigationLink {
                    AddView()
                } label: {
                    Image(systemName: "plus")
                }
                
                Menu(showingUsers) {
                    Picker("Display", selection: $showingUsers) {
                        Text("All")
                            .tag(
                                "All"
                            )
                        Text("Personal")
                            .tag(
                                "Personal"
                            )
                        Text("Business")
                            .tag(
                                "Business"
                            )
                    }
                }
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\ExpenseItem.name),
                                SortDescriptor(\ExpenseItem.price)
                            ])
                        Text("Sort by Price")
                            .tag([
                                SortDescriptor(\ExpenseItem.price),
                                SortDescriptor(\ExpenseItem.name)
                            ])
                    }
                }
                
            }
//            .sheet(isPresented: $showingAddExpense) {
//                AddView()
//            }
        }
    }
}




#Preview {
    ContentView()
}
