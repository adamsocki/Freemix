//
//  TestRouteOverlayMap.swift
//  Freemix
//
//  Created by Adam Socki on 7/31/22.
//

import Foundation
import MapKit


class TestRouteOverlayMap: NSObject, MKOverlay {
    
    let coordinate: CLLocationCoordinate2D
    let boundingMapRect: MKMapRect
    
    init(gtfs: GTFS) {
        boundingMapRect = gtfs.overlayBoundingMapRect
        coordinate = gtfs.midCoordinate
    }
    
}
