//
//  ChatView.swift
//  FireChat
//
//  Created by Michael Dacanay on 3/27/24.
//

import SwiftUI

struct ChatView: View {
    
    // Access authManager from the environment
    @Environment(AuthManager.self) var authManager
    
    @State var messageManager: MessageManager
    
    init(isMocked: Bool = false) {
        messageManager = MessageManager(isMocked: isMocked)
    }
    
    var body: some View {
        NavigationStack {
            Text("Welcome to FireChat!")
                .navigationTitle("Chat")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem {
                        Button("Sign out") {
                            authManager.signOut()
                        }
                    }
                }
        }
    }
}

#Preview {
    ChatView(isMocked: true) // <-- Pass in true to isMocked to use the mocked version of the message manager in the preview
        .environment(AuthManager(isMocked: true)) // <-- Pass an AuthManager instance into the preview environment as well (use the mocked version)
}
