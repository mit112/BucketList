//
//  File.swift
//  BucketList
//
//  Created by Mit Sheth on 2/10/24.
//

import MapKit
import Foundation

struct Location: Codable, Identifiable, Equatable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    #if DEBUG
    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "Lit by over 40000 light bulbs", latitude: 51.501, longitude: -0.141)
    #endif
}
