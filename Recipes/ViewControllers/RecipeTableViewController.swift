//
//  RecipeTableViewController.swift
//  Recipe1
//
//  Created by Stateful on 10/12/21.
//

import UIKit

class RecipeTableViewController: UITableViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var categoryNameTextField: UITextField!

    
    //MARK: - PROPERTIES
    var category: RecipeCategory?

    
    // MARK: - LIFECYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categoryNameTextField.text = category?.title
        tableView.reloadData()
    } //:willAPPEAR
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let category = category,
            let newTitle = categoryNameTextField.text else { return }
        RecipeCategoryController.sharedInstance.updateRecipeCategory(category: category, title: newTitle)
    } //: willDISAPPEAR

    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.recipes.count ?? 0
    } //: #ROWS

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else { return UITableViewCell() }
 
        let recipeIndex = category?.recipes[indexPath.row]
        cell.recipe     = recipeIndex
        cell.delegate   = self
 
        return cell
    } //: CELL CONFIG
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let category = category else { return }
            let recipe = category.recipes[indexPath.row]
            RecipeController.delete(recipe: recipe, in: category)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } //: DELETE
    } //: EDITING STYLE

    
    // MARK: - NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toRecipeDetail",
              let recipeDetailViewController = segue.destination as? RecipeDetailViewController,
              let selectedRow = tableView.indexPathForSelectedRow?.row else { return }
        let recipe = category?.recipes[selectedRow]
        recipeDetailViewController.recipe = recipe
    } //: SEGUE
    
    
    // MARK: - ACTIONS
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        guard let category = category else { return }
        RecipeController.createRecipe(in: category)
        let newRow = category.recipes.count - 1
        let indexPath = IndexPath(row: newRow, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    } //: ADD BUTTON
    
} //: CLASS


extension RecipeTableViewController: RecipeTableViewCellDelegate {
    func toggleFavoriteButtonTapped(cell: RecipeTableViewCell) {
        guard let recipeIndex = cell.recipe else { return }
        RecipeController.toggleFavorite(recipe: recipeIndex)
        cell.updateViews()
    } //: IMPLEMENT PROTOCOL
} //: EXTENSION
