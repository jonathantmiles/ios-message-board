//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Jonathan T. Miles on 8/8/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func Send(_ sender: Any) {
       guard let sender = nameTextField.text,
        let text = messsageTextField.text,
        let messageThread = messageThread else { return }
        
        messageThreadController?.createMessage(messageThread: messageThread, text: text, sender: sender, completion: { (error) in
            if let error = error {
                NSLog("Error creating new message: \(error)")
            }
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messsageTextField: UITextView!
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?

}
