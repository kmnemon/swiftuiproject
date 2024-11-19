//
//  DetaiView.swift
//  RecognizeWithDocument
//
//  Created by ke on 2024/11/6.
//

import SwiftUI

struct DetaiView: View {
    var person: Person
    
    var body: some View {
        person.photoImage?
            .resizable()
            .scaledToFit()
    }
}
