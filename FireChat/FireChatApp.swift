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
    
    @State private var authManager: AuthManager // <-- Create a state managed authManager property
    
    init() { // <-- Add an init
        FirebaseApp.configure() // <-- Configure Firebase app
        authManager = AuthManager() // <-- Initialize the authManager property
    }
    
    var body: some Scene {
        WindowGroup {
            
            if authManager.user != nil { // <-- Check if you have a non-nil user (means there is a logged in user)

                // We have a logged in user, go to ChatView
                ChatView() // <-- Add ChatView
                    .environment(authManager) // <-- Pass authManager to the environment
//                NavigationStack {
//                    Text("Welcome to FireChat!")
//                        .navigationTitle("Chat")
//                        .navigationBarTitleDisplayMode(.inline)
//                        .toolbar {
//                            ToolbarItem {
//                                Button("Sign out") {
//                                    authManager.signOut()
//                                }
//                            }
//                        }
//                }
            } else {

                // No logged in user, go to LoginView
                LoginView()
                    .environment(authManager) // <-- Pass the authManager into the environment
            }
        }
    }
}
