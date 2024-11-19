//
//  ContentView.swift
//  Friends
//
//  Created by ke on 11/1/24.
//

import SwiftUI

struct ContentView: View {
    @State private var users: [User] = [User]()
    
    var body: some View {
        NavigationStack {
            List(users){ user in
                NavigationLink {
                    DetailView(user: user)
                } label: {
                    VStack(alignment: .leading){
                        Text(user.name)
                            .font(.headline)
                        
                        Text("\(user.isActive)")
                    }
                }
             
            }
            .task{
                await loadData()
            }
        }
    }
    
    func loadData() async {
        guard self.users.isEmpty else {
            return
        }
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let(data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let users = try? decoder.decode([User].self, from: data){
                self.users = users
            }
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    ContentView()
}
