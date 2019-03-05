//
//  TableViewController.swift
//  Lab 5
//
//  Created by iosdev on 06/02/2019.
//  Copyright © 2019 iosdev. All rights reserved.
//

import UIKit
import os.log

class TableViewController: UITableViewController {
    
    var persons = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load the sample data.
        loadSamplePersons()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            persons.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "TableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TableViewCell  else {
            fatalError("The dequeued cell is not an instance of TableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let person = persons[indexPath.row]
        
        cell.nameLabel.text = person.name
        cell.heightLabel.text = String(person.height)
        cell.weightLabel.text = String(person.weight)
        cell.bmiLabel.text = String(Double(round(100*person.getBMI())/100))
        
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "AddItem":
           os_log("Adding a new person.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let ViewController = segue.destination as? ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedCell = sender as? TableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedPerson = persons[indexPath.row]
            ViewController.person = selectedPerson
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    //MARK: Actions
    @IBAction func unwindToPersonList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ViewController, let person = sourceViewController.person {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing person.
                persons[selectedIndexPath.row] = person
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new person.
                let newIndexPath = IndexPath(row: persons.count, section: 0)
                
                persons.append(person)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    private func loadSamplePersons() {
        
        guard let person1 = Person(name: "Nick", height: 170, weight: 89) else {
            fatalError("Unable to instantiate Nick")
        }
        
        guard let person2 = Person(name: "Joe", height: 190, weight: 95) else {
            fatalError("Unable to instantiate Joe")
        }
        
        persons += [person1, person2]
    }
}
