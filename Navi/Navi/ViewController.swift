import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    private let statusLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure status label
        statusLabel.frame = CGRect(x: 50, y: 100, width: view.frame.width - 100, height: 50)
        statusLabel.textAlignment = .center
        view.addSubview(statusLabel)
        
        // Set up location manager
        locationManager.delegate = self
        checkLocationServices()
    }

    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            // Location Services are enabled
            determineLocationAuthorization()
        } else {
            // Location Services are disabled
            statusLabel.text = "Location Services are disabled"
        }
    }

    func determineLocationAuthorization() {
        let status = locationManager.authorizationStatus
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            statusLabel.text = "Location access restricted"
        case .denied:
            statusLabel.text = "Location access denied"
        case .authorizedAlways, .authorizedWhenInUse:
            statusLabel.text = "Location access granted"
        @unknown default:
            statusLabel.text = "Unknown authorization status"
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        determineLocationAuthorization()
    }
}
