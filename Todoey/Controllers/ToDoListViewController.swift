//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    var itemArray = ["akif","gulnur","mehmet"]
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let items = defaults.array(forKey: "ToDoListArray") as? [String]{
            itemArray = items
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
       
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
//MARK: - add item button
    

    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
            var textField = UITextField()
            let alert = UIAlertController(title: "Add new ToDoey item", message:"", preferredStyle: .alert)

            let action = UIAlertAction(title: "Add Item", style: .default) { action in
                if let newItem = textField.text, !newItem.trimmingCharacters(in: .whitespaces).isEmpty {
                    self.itemArray.append(newItem)
                    self.defaults.set(self.itemArray,forKey: "ToDoListArray")
                    self.tableView.reloadData()
                } else {
                    print("ERROR: Empty or invalid input.")
                }
            }

            alert.addTextField { alertTextField in
                alertTextField.placeholder = "Add item here"
                textField = alertTextField
            }

            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }

}

