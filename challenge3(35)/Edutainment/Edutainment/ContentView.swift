//
//  ContentView.swift
//  Edutainment
//
//  Created by ke on 2024/10/8.
//

import SwiftUI

struct ContentView: View {
    @State private var selectLevel: Int = 2
    @State private var left: Int?
    @State private var right: Int?
    @State private var result: Int?
    @State private var userResult: Int?
    
    @State private var round = 5
    
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var score = 0
    @State private var showingFinal = false
    @State private var count = 0
    
    var body: some View {
        NavigationStack {
            Spacer()
            
            Text("What is \(left ?? 0) * \(right ?? 0) = ?")
                .font(.title)
            
            HStack {
                Text("Result:")
                TextField("number", value: $userResult, format: .number)
                Button("OK", action: enterNumber)
                .padding()
            }
            .font(.title)
            
            Spacer()
                .navigationTitle("Multi Game")
                .toolbar {
                    NavigationLink {
                        SettingView(selectLevel: $selectLevel, round: $round, onBack: continueGame)
                    } label: {
                        Text("Setting")
                            .font(.headline)
                    }
                }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: continueGame)
        } message: {
            Text("You score is \(score)")
        }
        .alert(scoreTitle, isPresented: $showingFinal) {
            Button("Restart", action: startGame)
        } message: {
            Text("Your final score is \(score), please restart the game")
        }
        .onAppear() {
            continueGame()
        }
    }
    
    func startGame() {
        continueGame()
        score = 0
        count = 0
    }
    
    func continueGame() {
        left = getRandomNumberFromLevel()
        right = getMultiplicationNumber()
        result = left! * right!
        userResult = nil
    }
    
    func enterNumber() {
        if userResult == result {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! The answer is \(result ?? 0)"
        }
        
        count += 1
        
        if count > round {
            showingFinal = true
        } else {
            showingScore = true
        }
    }
    
    func getRandomNumberFromLevel() -> Int {
        return Int.random(in: 1...selectLevel)
    }
    
    func getMultiplicationNumber() -> Int {
        return Int.random(in: 1...12)
    }
    
    
}

#Preview {
    ContentView()
}
