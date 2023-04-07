//
//  LocationPolicy.swift
//  FindPlaces
//
//  Created by Branimir Markovic on 19.4.22..
//

import Foundation

public protocol LocationPolicy {
    func isLocationValid(_ savedLocation: SavedLocation) -> Bool
    init(validFor: TimeInterval)
}
