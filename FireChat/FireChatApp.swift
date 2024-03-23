//
//  FireChatApp.swift
//  FireChat
//
//  Created by Michael Dacanay on 3/23/24.
//

import SwiftUI
import FirebaseCore

@main
struct FireChatApp: App {
    init() { // <-- Add an init
        FirebaseApp.configure() // <-- Configure Firebase app
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
