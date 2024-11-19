//
//  ColorCyclingRectangleView.swift
//  Drawing
//
//  Created by ke on 11/15/24.
//

import SwiftUI


/*
 Create a ColorCyclingRectangle shape that is the rectangular cousin of ColorCyclingCircle, allowing us to control the position of the gradient using one or more properties.
 Tip: Gradient positions like .top and .bottom are actually instances of UnitPoint, and you can create your own UnitPoint instances with X/Y values ranging from 0 to 1.
 */
//not finished yet
struct ColorCyclingRectangle: Shape {
    var thickness: Double
    

    
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



public struct ColorCyclingRectangleView: View {
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
        
    }
}
