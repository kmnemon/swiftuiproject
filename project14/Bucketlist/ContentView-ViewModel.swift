//
//  ContentView-ViewModel.swift
//  Bucketlist
//
//  Created by Paul Hudson on 10/12/2021.
//

import Foundation
import MapKit
import CoreLocation
import LocalAuthentication

extension ContentView {
    enum AuthenticationError: Error {
        case biometricNotAvailable
        case authenticationFailed(Error)
    }
    
    
    @Observable
    class ViewModel {
        private(set) var locations : [Location]
        var selectedPlace: Location?
        var isUnlocked = false
        var error: Error?
        
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        init() {
            do {
                //read data from savePathx.3
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Undable to save data.")
            }
        }
        
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        self.isUnlocked = true
                    } else {
//                        if let authenticationError = authenticationError {
//                            self.error =  AuthenticationError.authenticationFailed(authenticationError)
//                        } else {
//                            print("covert NSError to Error failed")
//                        }
                    }
                }
                
            } else {
                self.error = AuthenticationError.biometricNotAvailable
            }
        }
    }
}

