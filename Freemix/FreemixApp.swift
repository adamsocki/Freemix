//
//  FreemixApp.swift
//  Freemix
//
//  Created by Adam Socki on 7/19/22.
//

import SwiftUI

@main
struct FreemixApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
