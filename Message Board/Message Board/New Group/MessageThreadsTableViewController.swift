//
//  MessageThreadsTableViewController.swift
//  Message Board
//
//  Created by Jonathan T. Miles on 8/8/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        messageThreadController.fetchMessageThreads { (error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThreadController.messageThreads.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)

        let messageThread = messageThreadController.messageThreads[indexPath.row]
        cell.textLabel?.text = messageThread.title
        
        return cell
    }

    // MARK: - Custom functions

    @IBAction func textFieldAction(_ sender: Any) {
        guard let text = textOutletField.text else { return }
        messageThreadController.createMessageThread(title: text) { (error) in
            if let error = error {
                NSLog("Error creating new messageThread: \(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            let destVC = segue.destination as! MessageDetailTableViewController
            destVC.messageThreadController = messageThreadController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            destVC.messageThread = messageThreadController.messageThreads[indexPath.row]
        }
    }
    
    // MARK: - Properties
    
    let messageThreadController = MessageThreadController()
    
    @IBOutlet weak var textOutletField: UITextField!
    
}
