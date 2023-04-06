# SystemLocationManagerDecorator

SystemLocationManagerDecorator is an iOS Swift module that simplifies the process of retrieving a device's current location using CoreLocation. This class is a decorator for CLLocationManager, designed to handle location updates more efficiently by implementing a custom location policy and maintaining completion handlers.

## Key Features

1. **Custom location policy:** Define and use a custom location policy to determine if a saved location is still valid, allowing for efficient location updates and avoiding unnecessary calls to the system location manager.
2. **Multiple completion handlers:** Manage multiple location request completion handlers, ensuring that all requests are served with the most recent and valid location information.
3. **Automatic monitoring:** Automatically start monitoring location updates when a new request is made and stop monitoring once the location is updated, optimizing battery usage and system resources.
4. **CLLocationManagerDelegate:** Implements CLLocationManagerDelegate to handle location updates and errors effectively.

## Usage

1. Create an instance of SystemLocationManagerDecorator by passing a custom location policy and a CLLocationManager instance.
2. Use the `currentLocation(completion:)` method to request the device's current location, providing a completion handler that will be called when the location is available or when an error occurs.
3. The class automatically starts and stops monitoring location updates, using the custom location policy to determine if a saved location is still valid.

### Example

```swift
let locationManager = CLLocationManager()
let locationPolicy = MyCustomLocationPolicy()
let systemLocationManagerDecorator = SystemLocationManagerDecorator(locationPolicy: locationPolicy, locationManager: locationManager)

systemLocationManagerDecorator.currentLocation { result in
    switch result {
    case .success(let location):
        print("Current location: \(location)")
    case .failure(let error):
        print("Error getting location: \(error)")
    }
}
