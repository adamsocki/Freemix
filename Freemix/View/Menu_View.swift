//
//  Menu_View.swift
//  Freemix
//
//  Created by Adam Socki on 7/19/22.
//

import SwiftUI

struct Menu_View: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: Map_View()) {
                    Label("Map", systemImage: "map")
                }
                NavigationLink(destination: Import_GTFS_View()) {
                    Label("Import", systemImage: "square.and.arrow.down.on.square")
                }
              }
              .listStyle(SidebarListStyle())
              .navigationTitle("Sidebar")
        }
    }
}

struct Menu_View_Previews: PreviewProvider {
    static var previews: some View {
        Menu_View()
    }
}
