//
//  GridLayout.swift
//  Moonshot
//
//  Created by ke on 2024/10/14.
//

import SwiftUI

struct GridLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        ItemView(mission: mission)
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}
