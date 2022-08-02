//
//  GTFS.swift
//  Freemix
//
//  Created by Adam Socki on 7/31/22.
//

import Foundation
import MapKit

class GTFS {
    
    var boundary: [CLLocationCoordinate2D] = []
    
    var midCoordinate = CLLocationCoordinate2D()
    
    var overlayTopLeftCoordinate = CLLocationCoordinate2D()
    var overlayTopRightCoordinate = CLLocationCoordinate2D()
    var overlayBottomLeftCoordinate = CLLocationCoordinate2D()
    
    var overlayBoundingMapRect: MKMapRect {
        let topLeft = MKMapPoint(overlayTopLeftCoordinate)
        let topRight = MKMapPoint(overlayTopRightCoordinate)
        let bottomLeft = MKMapPoint(overlayBottomLeftCoordinate)
        
        return MKMapRect(
            x: topLeft.x,
            y: topLeft.y,
            width: fabs(topLeft.x - topRight.x),
            height: fabs(topLeft.y - bottomLeft.y))
    }
    
    static func parseCoord(dict: [String: Any], fieldName: String) -> CLLocationCoordinate2D {
      if let coord = dict[fieldName] as? String {
        let point = NSCoder.cgPoint(for: coord)
        return CLLocationCoordinate2D(
          latitude: CLLocationDegrees(point.x),
          longitude: CLLocationDegrees(point.y))
      }
      return CLLocationCoordinate2D()
    }
    
    init(filename: String) {
      guard
        let properties = GTFS.plist(filename) as? [String: Any],
        let boundaryPoints = properties["boundary"] as? [String]
        else { return }

//      midCoordinate = Park.parseCoord(dict: properties, fieldName: "midCoord")
//      overlayTopLeftCoordinate = Park.parseCoord(
//        dict: properties,
//        fieldName: "overlayTopLeftCoord")
//      overlayTopRightCoordinate = Park.parseCoord(
//        dict: properties,
//        fieldName: "overlayTopRightCoord")
//      overlayBottomLeftCoordinate = Park.parseCoord(
//        dict: properties,
//        fieldName: "overlayBottomLeftCoord")

      let cgPoints = boundaryPoints.map { NSCoder.cgPoint(for: $0) }
      boundary = cgPoints.map { CLLocationCoordinate2D(
        latitude: CLLocationDegrees($0.x),
        longitude: CLLocationDegrees($0.y))
      }
    }
    
    static func plist(_ plist: String) -> Any? {
      guard let filePath = Bundle.main.path(forResource: plist, ofType: "plist"),
        let data = FileManager.default.contents(atPath: filePath) else { return nil }
      do {
        return try PropertyListSerialization.propertyList(from: data, options: [], format: nil)
      } catch {
        return nil
      }
    }
    
    static func csv(_ csv: String) -> Any? {
        guard let filePath = Bundle.main.path(forResource: csv, ofType: "csv"),
              let data = FileManager.default.contents(atPath: filePath) else { return nil }
        do {
            return try PropertyListSerialization.propertyList(from: data, options: [], format: nil)
        } catch {
            return nil
        }
    }

    
    
}
