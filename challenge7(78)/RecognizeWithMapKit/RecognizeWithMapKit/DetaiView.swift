//
//  DetaiView.swift
//  RecognizeWithMapKit
//
//  Created by ke on 2024/11/6.
//

import SwiftUI
import MapKit

struct DetaiView: View {
    var person: Person
    
    var body: some View {
        NavigationStack {
            VStack {
                person.photoImage?
                    .resizable()
                    .scaledToFit()
                
                Map {
                    Marker(person.name, coordinate: CLLocationCoordinate2D(latitude: person.latitude, longitude: person.longitude))
                }
            }
        }
    }

}
