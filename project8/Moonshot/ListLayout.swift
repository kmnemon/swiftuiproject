//
//  ListLayout.swift
//  Moonshot
//
//  Created by ke on 2024/10/14.
//

import SwiftUI

struct ListLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
                        ItemView(mission: mission)
                    }
                }
                .padding([.horizontal, .bottom])
                .listRowBackground(Color.darkBackground)
            }
            .listStyle(.plain)
            .navigationDestination(for: Mission.self) { mission in
                MissionView(mission: mission, astronauts: astronauts)
            }
        }
    }
}



