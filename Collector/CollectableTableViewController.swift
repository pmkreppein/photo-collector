//
//  CollectableTableViewController.swift
//  Collector
//
//  Created by Peter M Kreppein on 10/25/18.
//  Copyright © 2018 Peter M Kreppein. All rights reserved.
//

import UIKit

class CollectableTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        getCollectables()
    }

    // MARK: - Table view data source
    var collectables: [Collectable] = []
    func getCollectables(){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let collectables = try? context.fetch(Collectable.fetchRequest()) {
                if let theCollectables = collectables as? [Collectable]{
                    self.collectables = theCollectables
                    tableView.reloadData()
                }
            }
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return collectables.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let collectable = collectables[indexPath.row]
        cell.textLabel?.text = collectable.title
        if let data = collectable.image {
            cell.imageView?.image = UIImage(data: data)
        }

        return cell
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let collectable = collectables[indexPath.row]
                context.delete(collectable)
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                getCollectables()
            }
        }
    }
   
}
