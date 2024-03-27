//
//  MessageManager.swift
//  FireChat
//
//  Created by Michael Dacanay on 3/26/24.
//

import Foundation
import FirebaseFirestore

@Observable // <-- Add the Observable macro
class MessageManager {

    var messages: [Message] = []

    init(isMocked: Bool = false) {
        if isMocked {
            messages = Message.mockedMessages
        } else {
            // TODO: Fetch messages from Firestore database

        }
    }

    // TODO: Save message

    // TODO: Get messages

}
