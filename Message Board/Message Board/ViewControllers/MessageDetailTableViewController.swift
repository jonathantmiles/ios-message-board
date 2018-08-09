//
//  MessageDetailTableViewController.swift
//  Message Board
//
//  Created by Jonathan T. Miles on 8/8/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import UIKit

class MessageDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = messageThread?.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (messageThread?.messages.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageDetailCell", for: indexPath)

        cell.textLabel?.text = messageThread?.messages[indexPath.row].sender
        cell.detailTextLabel?.text = messageThread?.messages[indexPath.row].text

        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateNewMessageSegue" {
            let destVC = segue.destination as! MessageDetailViewController
            destVC.messageThreadController = messageThreadController
            destVC.messageThread = messageThread
        }
    }

    // MARK: - Properties
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
}
