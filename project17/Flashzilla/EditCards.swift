//
//  EditCards.swift
//  Flashzilla
//
//  Created by Paul Hudson on 11/01/2022.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    var cards = Cards(cards: [])
    @State private var newPrompt = ""
    @State private var newAnswer = ""

    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card", action: addCard)
                }

                Section {
                    ForEach(0..<cards.items.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards.items[index].prompt)
                                .font(.headline)

                            Text(cards.items[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear(perform: cards.loadData)
        }
    }

    func done() {
        dismiss()
    }


    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }

        let card = Card(id: UUID(), prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.items.insert(card, at: 0)
        cards.saveData()
        
        newPrompt = ""
        newAnswer = ""
    }

    func removeCards(at offsets: IndexSet) {
        cards.items.remove(atOffsets: offsets)
        cards.saveData()
    }
}

#Preview {
    EditCards()
}
