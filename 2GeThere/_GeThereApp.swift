//
//  _GeThereApp.swift
//  2GeThere
//
//  Created by Haikal Lazuardi Fadil on 17/03/23.
//

import SwiftUI
import Firebase

@main
struct _GeThereApp: App {
    @StateObject var dataManager = DataManager()
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataManager)
        }
    }
}
