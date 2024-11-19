//
//  CardView.swift
//  Flashzilla
//
//  Created by Paul Hudson on 09/01/2022.
//

import SwiftUI

extension View {
    func fillCardColor(offset: CGSize, color: Color?) -> Color {
        if offset.width > 0 {
            return Color.green
        } else if offset.width < 0 {
           return Color.red
        } else {
            if let color = color {
                return color
            }
        }
        
        return Color.clear
    }
}



struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    
    @State private var feedback = UINotificationFeedbackGenerator()

    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @State private var color: Color?
    
    let card: Card
    var removal: (() -> Void)? = nil
    var insert: (() -> Void)? = nil

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                    ? .white
                    : .white.opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(fillCardColor(offset: offset, color: color))
                )
                .shadow(radius: 10)

            VStack {
                if voiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)

                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    feedback.prepare()
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        if offset.width > 0 {
                            feedback.notificationOccurred(.success)
                        } else {
                            feedback.notificationOccurred(.error)
                        }
                        
                        removal?()
                        
                        if offset.width < 0 {
                            insert?()
                        }

                    } else {
                        if offset.width > 0 {
                            color = .green
                        } else if offset.width < 0 {
                            color = .red
                        }
                        
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.spring(), value: offset)
    }
}

#Preview {
    CardView(card: .example)
}
       
