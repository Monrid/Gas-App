//
//  Gas_AppApp.swift
//  Gas App
//
//  Created by Monrid Rojanavisut on 13/4/2565 BE.
//

import SwiftUI
import Firebase



@main
struct Gas_AppApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
