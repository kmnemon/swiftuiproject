//
//  PickDiceView.swift
//  RollDice
//
//  Created by ke on 2024/11/15.
//

import SwiftUI

struct DiceView: View {
    var dice: Dice
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 50, height: 50)
            
            Text("\(dice.type)")
        }
    }
}
