//
//  ContentView.swift
//  Flashzilla
//
//  Created by Paul Hudson on 07/01/2022.
// modify support ios 17 by Ke

import SwiftUI

extension View {
    func stacked(card: Card, in cards: [Card]) -> some View {
        let total = cards.count
        let position = Int(cards.firstIndex(of: card)!)
        
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
    
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    var cards = Cards(cards: [])
    //    @State private var cards = Array<Card>(repeating: .example, count: 10)
    
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1000, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack {
            Image(decorative: 	"background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                
                ZStack {
                    ForEach(cards.items) { card in
                        CardView(card: card) {
                            withAnimation {
                                removeCard()
                            }
                        } insert: {
                            insertCard(card: card)
                        }
                        .stacked(card: card, in: cards.items)
                        .allowsHitTesting(card == cards.items.last)
                        .accessibilityHidden(card != cards.items.last)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.items.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: cards.items.count - 1)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard(at: cards.items.count - 1)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer is being correct.")
                    }
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if cards.items.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCards.init)
        .onAppear(perform: resetCards)
    }
    
    
    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        
        cards.items.remove(at: index)
        
        if cards.items.isEmpty {
            isActive = false
        }
    }
    
    func insertCard(card: Card) {
        cards.items.insert(Card(id: UUID(), prompt: card.prompt, answer: card.answer), at: 0)
    }
    
    func removeCard() {
        guard !cards.items.isEmpty else { return }
        
        cards.items.remove(at: cards.items.count - 1)
        
        if cards.items.isEmpty {
            isActive = false
        }
        
    }
    
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        cards.loadData()
    }
}

#Preview {
    ContentView()
}
