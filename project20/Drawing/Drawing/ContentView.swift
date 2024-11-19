//
//  ContentView.swift
//  Drawing
//
//  Created by ke on 2024/11/13.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("Spirograph", destination: SpirographView())
            NavigationLink("Arrow", destination: ArrowView())
            NavigationLink("ColorCyclingRectangle", destination: ColorCyclingRectangleView())
        }
    }

}


#Preview {
    ContentView()
}
