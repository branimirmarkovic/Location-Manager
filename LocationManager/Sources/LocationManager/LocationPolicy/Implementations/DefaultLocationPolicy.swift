//
//  DefaultLocationPolicy.swift
//  FindPlaces
//
//  Created by Branimir Markovic on 19.4.22..
//

import Foundation

public struct DefaultLocationPolicy: LocationPolicy {
    private var validFor: TimeInterval = 180
    
    public  init(validFor: TimeInterval) {
        self.validFor = validFor
    }

    public func isLocationValid(_ savedLocation: SavedLocation) -> Bool {

        let maxValidDate = savedLocation.timeStamp + validFor
        return maxValidDate >= Date()
    }
}
