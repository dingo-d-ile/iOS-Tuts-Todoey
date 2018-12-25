//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Pius Asare on 16/12/2018.
//  Copyright © 2018 PapayaLabz. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    //Code smell. Hints at possible bad code but not an issue. According to the Realm Docs you do this because this can fail when app is first launched if resources are constraint
    let realm = try! Realm()
    
    var categoryArray: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        tableView.separatorStyle = .none
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //Handler
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.bgColor = UIColor.randomFlat.hexValue()
            self.save(category: newCategory)
            //            self.defaults.set(self.todoItems, forKey: "TodoListArray")
            //            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No categories added yet"
        if let catColor = categoryArray?[indexPath.row].bgColor {
            guard let hex = UIColor.init(hexString: catColor) else { fatalError() }
            cell.backgroundColor = hex
            cell.textLabel?.textColor = ContrastColorOf(hex, returnFlat: true)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    //MARK: - Data Manipulation Methods
    func loadCategories() {
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            };
        } catch {
            print("Error encoding category array, \(error)")
        }
        self.tableView.reloadData()
    }
    
    //MARK: Delete Data from Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        do {
            try self.realm.write {
                if let ct = self.categoryArray?[indexPath.row] {
                    self.realm.delete(ct) //this is to delete an item
                }
            }
        } catch {
            print("Error encoding category array, \(error)")
        }
    }
}
