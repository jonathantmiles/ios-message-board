//
//  MessageThread.swift
//  Message Board
//
//  Created by Jonathan T. Miles on 8/8/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable {
    
    init(title: String, identifier: String = UUID().uuidString, messages: [MessageThread.Message] = []) {
        self.title = title
        self.identifier = identifier
        self.messages = messages
    }
    
    let title: String
    let identifier: String
    
    var messages: [MessageThread.Message]
    
    struct Message: Equatable, Codable {
        let text: String
        let sender: String
        let timestamp: Date = Date()
    }
    
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return
            lhs.title == rhs.title &&
            lhs.identifier == rhs.identifier &&
            lhs.messages == rhs.messages
    }
    
    
}
