//
//  Setting.swift
//  Edutainment
//
//  Created by ke on 2024/10/8.
//

import SwiftUI

struct SettingView: View {
    @Binding var selectLevel: Int
    @Binding var round: Int
    
    var onBack: () -> Void
    
    let rounds = [5, 10, 20]
    
    var body: some View {
        Section("What level do you want to play?") {
            Stepper("Level: \(selectLevel)", value: $selectLevel, in: 2...12, step: 1)
        }
        
        Section("How many round do you want to play?") {
            Picker("Round", selection: $round) {
                ForEach(rounds, id:\.self) {
                    Text($0, format: .number)
                }
            }
            .pickerStyle(.segmented)
        }
        .onDisappear {
            onBack()
        }
    }
}

