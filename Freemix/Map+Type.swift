//
//  Map+Type.swift
//  Freemix
//
//  Created by Adam Socki on 7/29/22.
//

import Foundation
import SwiftUI
import MapKit


extension Map {
    func mapStyle(_ mapType: MKMapType) -> some View {
        MKMapView.appearance().mapType = mapType
        return self
    }
}
