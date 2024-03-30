//
//  MessageManager.swift
//  FireChat
//
//  Created by Michael Dacanay on 3/26/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

@Observable // <-- Add the Observable macro
class MessageManager {

    var messages: [Message] = []
    
    private let dataBase = Firestore.firestore() // <-- Add an instance of the Firestore used to interact with your Firestore database

    init(isMocked: Bool = false) {
        if isMocked {
            messages = Message.mockedMessages
        } else {
            // Fetch messages from Firestore database
            getMessages() // <-- Start fetching messages when MessageManager is created
        }
    }

    // Save message
    func getMessages() {

        // Access the "Messages" collection group in Firestore and listen for any changes
        dataBase.collectionGroup("messages").addSnapshotListener { querySnapshot, error in

            // Get the documents for the messages collection (a document represents a message in this case)
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            // Map Firestore documents to Message objects
            let messages = documents.compactMap { document in
                do {

                    // Decode message document to your Message data model
                    return try document.data(as: Message.self)
                } catch {
                    print("Error decoding document into message: \(error)")
                    return nil
                }
            }
            
            // Update the messages property with the fetched messages (sorting ascending timestamp)
            self.messages = messages.sorted(by: { $0.timestamp < $1.timestamp })
        }
    }

    // Get messages
    func sendMessage(text: String, username: String) {
        do {

            // Create a message object
            let message = Message(id: UUID().uuidString, text: text, timestamp: Date(), username: username)

            // Save the message to your Firestore database
            try dataBase.collection("messages").document().setData(from: message)

        } catch {
            print("Error sending message to Firestore: \(error)")
        }
    }

}
