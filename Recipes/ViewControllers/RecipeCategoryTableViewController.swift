//
//  RecipeCategoryTableViewController.swift
//  Recipe1
//
//  Created by Stateful on 10/12/21.
//

import UIKit

class RecipeCategoryTableViewController: UITableViewController {
    
    
    // MARK: - LIFECYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    } //: willAPPEAR
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecipeCategoryController.sharedInstance.categories.count
    } //: #ROWS
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCategory", for: indexPath)
        
        let category = RecipeCategoryController.sharedInstance.categories[indexPath.row]
        cell.textLabel?.text = category.title
        cell.detailTextLabel?.text = "\(category.recipes.count) Recipes"
        return cell
    } //: CELL CONFIG
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let category = RecipeCategoryController.sharedInstance.categories[indexPath.row]
            RecipeCategoryController.sharedInstance.delete(category: category)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } //: DELETE
    } //: EDITING STYLE
    
    
    // MARK: - NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toRecipeCategoryDetail",
              let categoryDetailViewController = segue.destination as? RecipeTableViewController,
              let selectedRow = tableView.indexPathForSelectedRow?.row else { return }
        let category = RecipeCategoryController.sharedInstance.categories[selectedRow]
        categoryDetailViewController.category = category
    } //: SEGUE
    
    
    // MARK: - ACTIONS
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        RecipeCategoryController.sharedInstance.createRecipeCategory()
        let newRow = RecipeCategoryController.sharedInstance.categories.count - 1
        let indexPath = IndexPath(row: newRow, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    } //: ADD BUTTON
    
} //: CLASS
