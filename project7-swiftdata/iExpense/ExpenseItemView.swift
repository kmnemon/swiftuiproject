//
//  ExpenseItemView.swift
//  iExpense
//
//  Created by ke on 10/26/24.
//

import SwiftUI
import SwiftData

struct ExpenseItemView: View {
    @Environment(\.modelContext) var modelContext
    @Query var items: [ExpenseItem]
    
    var body: some View {
        List {
            ForEach(items) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        
                        Text(item.type)
                    }
                    
                    Spacer()
                    
                    Text(item.price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .moneyStyle(at: item.price)
                }
                
            }
            .onDelete(perform: removeItems)
        }
    }
    
    init(showingUsers: String, sortOrder: [SortDescriptor<ExpenseItem>]) {
        if showingUsers == "All" {
            _items = Query(sort: sortOrder)
        } else if showingUsers == "Personal" {
            _items = Query(filter: #Predicate<ExpenseItem> { item in
                item.type == "Personal"
            }, sort: sortOrder)
        } else if showingUsers == "Business" {
            _items = Query(filter: #Predicate<ExpenseItem> { item in
                item.type == "Business"
            }, sort: sortOrder)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let item = items[offset]
            modelContext.delete(item)
        }
    }
}


#Preview {
    ExpenseItemView(showingUsers: "All", sortOrder: [SortDescriptor(\ExpenseItem.name), SortDescriptor(\ExpenseItem.type)])
        .modelContainer(for: ExpenseItem.self)
}
