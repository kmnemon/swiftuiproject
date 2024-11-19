//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Paul Hudson on 11/10/2023.
//

import SwiftUI

struct FlagImage: View {
    var country: String
    
    var body: some View {
        Image(country)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct ProminentTitles: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundStyle(.white)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(ProminentTitles())
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var showingFinal = false
    @State private var count = 0
    
    @State private var animationAmounts = [0.0, 0.0, 0.0]
    @State private var fadeOuts = [1.0, 1.0, 1.0]
    @State private var scales = [1.0, 1.0, 1.0]
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "",
        "Germany": "",
        "Ireland": "",
        "Italy": "",
        "Nigeria": "",
        "Poland": "",
        "Spain": "",
        "UK": "",
        "Ukraine": "",
        "US": ""
    ]
    

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess the Flag")
                    .titleStyle()

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            
                            withAnimation {
                                animationAmounts[number] += 360
                                
                                for index in 0..<3 {
                                    if index != number {
                                        fadeOuts[index] = 0.25
                                        scales[index] = 0.5
                                    }
                                }
                            }
                        } label: {
                            FlagImage(country: countries[number])
                                .rotation3DEffect(.degrees(animationAmounts[number]), axis: (x: 0, y: 1, z: 0))
                                .opacity(fadeOuts[number])
                                .scaleEffect(scales[number])
                        }
                        .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                       
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert(scoreTitle, isPresented: $showingFinal) {
            Button("Restart", action: restart)
        } message: {
            Text("Your final score is \(score), please restart game")
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That’s the flag of \(countries[number])"
        }

        count += 1
        if count > 3 {
            showingFinal = true
        } else {
            showingScore = true
        }
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        animationAmounts = [0.0, 0.0, 0.0]
        fadeOuts = [1.0, 1.0, 1.0]
        scales = [1.0, 1.0, 1.0]
    }
    
    func restart() {
        askQuestion()
        count = 0
        score = 0
    }
}

#Preview {
    ContentView()
}
