//
//  ContentView.swift
//  HabitTracking
//
//  Created by ke on 10/19/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddActivity: Bool = false
    
    var activities: Activities = .init()

    
    var body: some View {
        NavigationStack {
            List{
                ForEach(activities.activities) { activity in
                    NavigationLink {
                        VStack {
                            ActivityDetail(index: activities.activities.firstIndex(of: activity)!, activities: activities)
                        }
                    } label: {
                        Text(activity.title)
                            .font(.headline)
                    }
                }
            }
            .toolbar {
                Button("Add", systemImage: "plus") {
                    showingAddActivity = true
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddActivityView(activities: activities)
            }
        }
    }
}

#Preview {
    ContentView()
}
