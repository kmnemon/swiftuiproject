//
//  ContentView.swift
//  GeometryReaderProject
//
//  Created by ke on 2024/11/12.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
//                            .background(colors[index % 7])
                            .background(Color(hue: min(1, proxy.frame(in: .global).minY / 800),
                                              saturation: min(1, proxy.frame(in: .global).minY / 200),
                                              brightness: min(1, proxy.frame(in: .global).minY / 400)))
                            .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(min(1, proxy.frame(in: .global).minY / 200))
                            .scaleEffect(max(0.5, scaleFactor(position: proxy.frame(in: .global).minY)))
//                        HStack {
                            Text("\(proxy.frame(in: .global).minY)")
//                            Text("\(scaleFactor(position: proxy.frame(in: .global).minY))")
//                        }
                    }
                    .frame(height: 40)
                }
            }
        }
    }
    
    func scaleFactor(position: Double) -> Double {
        var scaleFactor: Double
        
        if position < 200 {
            scaleFactor = position / 200
        } else if position > 600 {
            scaleFactor = position / 600
        } else {
            scaleFactor = 1
        }
        
        
        return scaleFactor
    }
}

#Preview {
    ContentView()
}
