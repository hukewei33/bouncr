//
//  BouncrApp.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/1/22.
//

import SwiftUI

@main
struct BouncrApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
