//
//  SystemLocationManagerDecorator.swift
//  FindPlaces
//
//  Created by Branimir Markovic on 19.4.22..
//

import CoreLocation

public typealias LocationResult = Result<CLLocation, Error>

public class LocationManager: NSObject {
    private var locationManager: CLLocationManager
    private var locationCompletionHandlers: [((Result<CLLocation,Error>) -> Void)] = []

    private let locationPolicy: LocationPolicy

    private var lastLocation: SavedLocation?

    public init(locationPolicy: LocationPolicy,
         locationManager: CLLocationManager ) {
        self.locationPolicy = locationPolicy
        self.locationManager = locationManager
        super.init()
    }

    public func currentLocation(completion: @escaping (Result<CLLocation, Error>) -> Void) {
        if let lastLocation = lastLocation, locationPolicy.isLocationValid(lastLocation) {
            completion(.success(lastLocation.location))
        } else {
            locationCompletionHandlers.append(completion)
            starMonitoring()

        }

    }

    private func starMonitoring() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

    private func didComplete(result: Result<CLLocation,Error>) {
        locationManager.stopUpdatingLocation()
        locationCompletionHandlers.forEach { completion in
            completion(result)
        }
        locationCompletionHandlers = []
        locationManager.delegate = nil
    }

}

extension LocationManager: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            didComplete(result: .failure(NSError(domain: "No locations", code: 0, userInfo: nil)))
            return}
        lastLocation = SavedLocation(timeStamp: Date(), location: location)
        didComplete(result: .success(location))

    }
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        didComplete(result: .failure(error))
    }

    
}
