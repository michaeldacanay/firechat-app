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
            
            ScrollView { // <-- Add ScrollView
                VStack { // <-- Add VStack
                    ForEach(messageManager.messages) { message in // <-- Add ForEach, accessing the messages property of the message manager
                        MessageRow(text: message.text, isOutgoing: authManager.userEmail == message.username) // <-- Display the text for each message
                    }
                }
            }
            .defaultScrollAnchor(.bottom)
            .navigationTitle("Chat")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("Sign out") {
                        authManager.signOut()
                    }
                }
            }
            
//            Text("Welcome to FireChat!")
//                .navigationTitle("Chat")
//                .navigationBarTitleDisplayMode(.inline)
//                .toolbar {
//                    ToolbarItem {
//                        Button("Sign out") {
//                            authManager.signOut()
//                        }
//                    }
//                }
        }
    }
}

struct MessageRow: View {
    let text: String // <-- The message text
    let isOutgoing: Bool // <-- true if sent by the current user

    var body: some View {
        HStack {
            if isOutgoing {
                Spacer() // <-- Spacer shifts message bubble to the right for outgoing messages
            }
            messageBubble // <-- The message bubble
            if !isOutgoing {
                Spacer() // <-- Spacer shifts message bubble to the left for incoming messages
            }
        }
    }

    private var messageBubble: some View {
        Text(text)
            .fixedSize(horizontal: false, vertical: true) // <-- Allow message text to expand and wrap vertically if needed
            .foregroundStyle(isOutgoing ? .white : .primary) // <-- Set the text color based on outgoing status
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 20.0) // <-- Add bubble shape to the background
                    .fill(isOutgoing ? Color.blue.gradient : Color(.systemGray5).gradient) // <-- Set bubble color based on outgoing status
            )
            .padding(isOutgoing ? .trailing : .leading, 12) // <-- Set padding based on outgoing status
            .containerRelativeFrame(.horizontal, count: 7, span: 5, spacing: 0, alignment: isOutgoing ? .trailing : .leading) // <-- Set message size relative to container (the scroll view width in this case)
    }
}

#Preview {
    ChatView(isMocked: true) // <-- Pass in true to isMocked to use the mocked version of the message manager in the preview
        .environment(AuthManager(isMocked: true)) // <-- Pass an AuthManager instance into the preview environment as well (use the mocked version)
}
