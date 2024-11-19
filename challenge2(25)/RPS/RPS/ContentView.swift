//
//  ContentView.swift
//  RPS
//
//  Created by ke on 2024/9/22.
//

import SwiftUI

struct ContentView: View {
    //    @State private var rps = ["rock", "paper", "scissors"]
    @State private var computerChoose = Int.random(in: 0...2)
    
    @State private var score = 0
    @State private var count = 0
    
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var showFinal = false
    
    @State private var showPCRock = true
    @State private var showPCPaper = true
    @State private var showPCScissors = true
    
    @State private var showUserRock = true
    @State private var showUserPaper = true
    @State private var showUserScissors = true
    
    
    
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Text("RPS Game")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
                
                Text("Computer")
                    .foregroundStyle(.yellow)
                    .font(.title.monospacedDigit())
                
                HStack {
                    if showPCScissors {
                        Image(systemName: "pencil.slash")
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                            .padding()
                    }
                    
                    
                    if showPCPaper {
                        Image(systemName: "square")
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                            .padding()
                    }
                    
                    if showPCRock {
                        Image(systemName: "circle.fill")
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                            .padding()
                    }
                }
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                Text("Me")
                    .foregroundStyle(.yellow)
                    .font(.title.monospacedDigit())
                HStack {
                    if showUserRock {
                        Button {
                            winOrLose(userChoose: 0)
                        } label: {
                            Image(systemName: "circle.fill")
                                .foregroundStyle(.white)
                                .font(.largeTitle)
                                .padding()
                        }
                    }
                    
                    if showUserPaper {
                        Button {
                            winOrLose(userChoose: 1)
                        } label: {
                            Image(systemName: "square")
                                .foregroundStyle(.white)
                                .font(.largeTitle)
                                .padding()
                        }
                    }
                    
                    if showUserScissors {
                        Button {
                            winOrLose(userChoose: 2)
                        } label: {
                            Image(systemName: "pencil.slash")
                                .foregroundStyle(.white)
                                .font(.largeTitle)
                                .padding()
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: again)
        } message: {
            Text("Your score is \(score)")
        }
        .alert(scoreTitle, isPresented: $showFinal) {
            Button("Restart", action: restart)
        } message: {
            Text("Your final score is \(score), please restart game")
        }
    }
    
    
    func winOrLose(userChoose: Int) {
        if computerChoose == 0 {
            showPCPaper = false
            showPCScissors = false
        } else if computerChoose == 1 {
            showPCRock = false
            showPCScissors = false
        } else {
            showPCRock = false
            showPCPaper = false
        }
        
        if userChoose == 0 {
            showUserPaper = false
            showUserScissors = false
        } else if userChoose == 1 {
            showUserRock = false
            showUserScissors = false
        } else {
            showUserRock = false
            showUserPaper = false
        }
        
        if computerChoose == userChoose {
            scoreTitle = "Draw"
        } else if (computerChoose + 1) % 3 == userChoose {
            score += 1
            scoreTitle = "You Win"
        } else {
            score -= 1
            scoreTitle = "You Lose"
        }
        
        count += 1
        if count > 5 {
            if score > 0 {
                scoreTitle = "Finally You Win"
            } else if score == 0 {
                scoreTitle = "Finally Draw"
            } else {
                scoreTitle = "Sorry, You Lose"
            }
            showFinal = true
        } else {
            showingScore = true
        }
    }
    
    func again() {
        computerChoose = Int.random(in: 0...2)
        
        showPCRock = true
        showPCPaper = true
        showPCScissors = true
        
        showUserRock = true
        showUserPaper = true
        showUserScissors = true
    }
    
    func restart() {
        computerChoose = Int.random(in: 0...2)
        count = 0
        score = 0
        
        showPCRock = true
        showPCPaper = true
        showPCScissors = true
        
        showUserRock = true
        showUserPaper = true
        showUserScissors = true
    }
}

#Preview {
    ContentView()
}
