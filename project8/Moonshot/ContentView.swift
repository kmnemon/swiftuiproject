//
//  ContentView.swift
//  Moonshot
//
//  Created by Paul Hudson on 29/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingGrid = true
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    var body: some View {
        NavigationStack {
            Group {
                if showingGrid {
                    GridLayout(astronauts: self.astronauts, missions: self.missions)
                } else {
                    ListLayout(astronauts: self.astronauts, missions: self.missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("ChangeShow"){
                        showingGrid.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
