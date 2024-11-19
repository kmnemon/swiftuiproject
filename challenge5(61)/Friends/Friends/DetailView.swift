//
//  DetailView.swift
//  Friends
//
//  Created by ke on 2024/11/1.
//

import SwiftUI

struct DetailView: View {
    let user: User
    
    var body: some View {
        NavigationStack {
            List(user.friends) {
                Text($0.name)
            }
            .navigationTitle("Friends")
        }
    }
}
