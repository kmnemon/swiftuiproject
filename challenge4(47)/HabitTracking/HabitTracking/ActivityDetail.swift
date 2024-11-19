//
//  ActivityDetail.swift
//  HabitTracking
//
//  Created by ke on 10/19/24.
//

import SwiftUI

struct ActivityDetail: View {    
    var index: Int
    var activities: Activities
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("\(activities.activities[index].completionCount)")
                    .font(.largeTitle)
                
                Button("Increase Completion") {
                    activities.activities[index].completionCount += 1
                }
                .padding()
                
                Divider()
                
                HStack {
                    Text("Description: \(activities.activities[index].description)")
                    Spacer()
                }
                .padding()
                
            }
            .navigationTitle(activities.activities[index].title)
            
            Spacer()
        }
    }
}


