//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Mit Sheth on 2/14/24.
//

import CoreLocation
import MapKit
import Foundation
import LocalAuthentication

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedLocation: Location?
        var isUnlocked = true
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        var mapMode = false
        
        init() {
            do {
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
                print("Unable to save data.")
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }
        
        func updateLocation(location: Location) {
            guard let selectedLocation else { return }
            if let index = locations.firstIndex(of: selectedLocation) {
                locations[index] = selectedLocation
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Unlock to access places."
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        self.isUnlocked = true
                    } else {
                        //error
                    }
                }
            } else {
                // no biometrics
            }
        }
        
        func changeMapMode() {
            mapMode.toggle()
        }
    }
}
