//
//  HistoryTable.swift
//  Lab 5
//
//  Created by iosdev on 05/02/2019.
//  Copyright © 2019 iosdev. All rights reserved.
//

import UIKit

class HistoryTable: UITableViewController {
    
    var history = [String]()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
}
