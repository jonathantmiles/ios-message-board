//
//  MessageThreadController.swift
//  Message Board
//
//  Created by Jonathan T. Miles on 8/8/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        let messageThread: MessageThread = MessageThread(title: title)
        let url = MessageThreadController.baseURL
            .appendingPathComponent(messageThread.identifier)
            .appendingPathExtension("json")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            let jsonEncoder = JSONEncoder()
            request.httpBody = try jsonEncoder.encode(messageThread)
        } catch {
            NSLog("Unable to encode \(messageThread): \(error)")
            completion(error)
            return
        }
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error saving data on server: \(error)")
                completion(error)
                return
            } else {
                self.messageThreads.append(messageThread)
            }
            completion(nil)
        }.resume()
    }
    
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping(Error?) -> Void) {
        let message = MessageThread.Message(text: text, sender: sender)
        guard let index = messageThreads.index(of: messageThread) else { return }
        let url = MessageThreadController.baseURL
            .appendingPathComponent(messageThread.identifier)
            .appendingPathComponent("messages")
            .appendingPathExtension("json")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONEncoder().encode(message)
        } catch {
            NSLog("Unable to encode \(message): \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error saving message on server: \(error)")
                completion(error)
                return
            } else {
                self.messageThreads[index].messages.append(message)
            }
            completion(nil)
        }.resume()
    }
    
    func fetchMessageThreads(completion: @escaping (Error?) -> Void) {
        let url = MessageThreadController.baseURL
            .appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: url) { (data , _, error) in
            if let error = error {
                NSLog("error fetching message threads: \(error)")
                completion(error)
            }
            guard let data = data else {
                completion(NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let messageThreadDictionaries = try jsonDecoder.decode([String: MessageThread].self, from: data)
                let messageThreads = messageThreadDictionaries.map({ (uuID, messageThread) -> MessageThread in
                    messageThread
                })
                self.messageThreads = messageThreads
                completion(nil)
            } catch {
                NSLog("Error receiving data: \(error)")
                completion(error)
                return
            }
        }.resume()
        
    }
    
    // MARK: - Properties
    
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    
    var messageThreads: [MessageThread] = []
    
}
