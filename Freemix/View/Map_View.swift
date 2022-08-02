//
//  Map_View.swift
//  Freemix
//
//  Created by Adam Socki on 7/19/22.
//

import SwiftUI
import MapKit
import Foundation


//let gtfs = loadCSV(from: "stops.csv")
//let gtfsRoute = loadCSV(from: "route")
let mapView = MKMapView(frame: UIScreen.main.bounds)

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct Map_View: View {
    var latitude: Double
    var longitude: Double
    
    @State var displayRoute = false
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 32.775461, longitude: -96.806822),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    @State private var mapType: MKMapType = .standard
    
    //@State private var
    
    init() {
        MKMapView.appearance().mapType = .satellite
        let map = MKMapView.appearance()
        
        map.mapType = .satellite
        latitude =  34.011_286
        longitude = -116.166_868
    }
    @ViewBuilder var body: some View {
        ZStack {
            UIKitMapView(region: region, mapType: mapType)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Button("Display Route") {
                    self.displayRoute.toggle()
                    self.updateMapOverlayViews()
                }
                .foregroundColor(displayRoute ? .white : .red)
                .background(displayRoute ? Color.green : Color.clear)
//                HStack {
//                    Picker("", selection: $mapType) {
//                        Text("Standard").tag(MKMapType.standard)
//                        Text("Hybrid").tag(MKMapType.hybrid)
//                        Text("Satellite").tag(MKMapType.satelliteFlyover)
//
//                    }
//                    .padding([.leading, .trailing], 70)
//                    .offset(y: -40)
//                    .pickerStyle(.segmented)
//                }
            }
        }
    }
    
    
    
    func addOverlay(_ overlay: MKOverlay) {
//        let overlay = TestRouteOverlayMap(gtfs: gtfs)
//        mapView.addOverlay(overlay)
    }
    
    func addRoute() {
        
       // guard let points = GTFS.plist("route") as? [String] else { return }
        guard let points = GTFS.plist("route") as? [String] else { return }
        let cgPoints = points.map { NSCoder.cgPoint(for: $0) }
        let coords = cgPoints.map { CLLocationCoordinate2D(
          latitude: CLLocationDegrees($0.x),
          longitude: CLLocationDegrees($0.y))
        }
        
        let myPolyline = MKPolyline(coordinates: coords, count: coords.count)
        mapView.addOverlay(myPolyline)
    }
    
    
    func updateMapOverlayViews() {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        
        if displayRoute { addRoute() }
    }
}

struct Map_View_Previews: PreviewProvider {
    static var previews: some View {
        Map_View()
    }
}

struct UIKitMapView: UIViewRepresentable {
    let region: MKCoordinateRegion
    let mapType: MKMapType
    
    func makeUIView(context: Context) -> MKMapView {

        mapView.setRegion(region, animated: false)
        mapView.mapType = mapType
        mapView.isRotateEnabled = false
        
        mapView.region = region
        mapView.delegate = context.coordinator

        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.mapType = mapType
    }
    

    class MapCoordinator: NSObject, MKMapViewDelegate {
        var parent: UIKitMapView
        
        init(_ parent: UIKitMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            if overlay is MKPolyline {
              let lineView = MKPolylineRenderer(overlay: overlay)
              lineView.strokeColor = .yellow
                lineView.lineWidth = 3
              return lineView
            }
          return MKOverlayRenderer()
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        MapCoordinator(self)
    }
}
