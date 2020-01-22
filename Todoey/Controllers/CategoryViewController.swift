//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Fahad Ali on 22/12/2019.
//  Copyright © 2019 Larasoft. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    //MARK: - Tableview Datasource Methods
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categories[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error saving the category, \(error)")
        }

        tableView.reloadData()
    }
    
    func loadCategories(with request : NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            try categories = context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            if textField.text != "" {
                let newCategory = Category(context: self.context)
                newCategory.name = textField.text!
                
                self.categories.append(newCategory)

                self.saveCategories()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new category"
            
            textField = alertTextField
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}
