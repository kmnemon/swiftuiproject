//
//  ArrowView.swift
//  Drawing
//
//  Created by ke on 11/15/24.
//

import SwiftUI

struct Arrow: Shape {
    var thickness: Double
    
    var animatableData: Double {
        get { thickness }
        set { thickness = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        
        
        return path
    }
}



public struct ArrowView: View {
    @State private var thickness = 1.0
    
    public var body: some View {
        Arrow(thickness: thickness)
            .stroke(Color(hue: 0.7, saturation: 1, brightness: 0.5), lineWidth: thickness)
            .frame(width: 300, height: 300)
            .onTapGesture {
                withAnimation {
                    thickness = Double.random(in: 1...40)
                }
                
            }
        
        Slider(value: $thickness, in: 1...40)
    }
}
