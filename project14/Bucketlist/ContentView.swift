//
//  ContentView.swift
//  Bucketlist
//
//  Created by Paul Hudson on 08/12/2021.
//  Modify by ke on 04/5/2024 support ios17

import SwiftUI
import MapKit


struct ContentView: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    @State private var mapStyle = MapStyle.standard
    @State private var style = "standard"
    @State private var viewModel = ViewModel()
    
    @State private var showingAlert = false
    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(mapStyle)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditView(location: place) {
                            viewModel.update(location: $0)
                        }
                    }
                    
                }
                VStack {
                    HStack {
                        Spacer()
                        
                        Button {
                            if style == "standard" {
                                mapStyle = .hybrid
                                style = "hybrid"
                            } else {
                                mapStyle = .standard
                                style = "standard"
                            }
                        } label: {
                            Text(style)
                                .foregroundStyle(.white)
                                .frame(width: 100, height: 30)
                                .padding()
                        }
                    }
                    
                    Spacer()
                }
            }
        } else {
            Button {
                do {
                    viewModel.authenticate()
                    if viewModel.error != nil {
                        showingAlert = true
                    }
                }
            } label: {
                Text("Unlock Places")
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
            .alert("authenticate failed", isPresented: $showingAlert) {
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Do not support Face ID")
            }
            
        }
    }
}

#Preview {
    ContentView()
}
