//
//  EditLocation-ViewModel.swift
//  BucketList
//
//  Created by Mit Sheth on 2/15/24.
//

import Foundation

extension EditLocation {
    @Observable
    class ViewModel {
        var location: Location
        private var name: String
        private var description: String
        
        init(location: Location, name: String, description: String) {
            self.location = location
            self.name = name
            self.description = description
        }
    }
}
