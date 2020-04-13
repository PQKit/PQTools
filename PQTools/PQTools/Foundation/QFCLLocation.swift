

import Foundation
import CoreLocation
public extension Reactive where Base == CLLocation {
    var toString: String {
        
        let latitude = String(format: "%.3f", pq.coordinate.latitude)
        let longitude = String(format: "%.3f", pq.coordinate.longitude)
        
        return "\(latitude), \(longitude)"
    }
}
