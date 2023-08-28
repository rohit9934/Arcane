//
//  ArcaneApp.swift
//  Arcane
//
//  Created by Rohit Sharma on 28/08/23.
//

import SwiftUI

@main
struct ArcaneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
