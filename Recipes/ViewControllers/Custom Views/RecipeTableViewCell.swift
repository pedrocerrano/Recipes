//
//  RecipeTableViewCell.swift
//  Recipes
//
//  Created by iMac Pro on 2/14/23.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    //MARK: - OUTLETS
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeCaloriesLabel: UILabel!
    @IBOutlet weak var recipeFavoriteButton: UIButton!
    
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        } //: PROPERTY OBSERVER
    } //: COMPUTED
    
    
    //MARK: - HELPER FUNCTIONS
    func updateViews() {
        guard let recipe = recipe else { return }
        recipeNameLabel.text        = recipe.title
        recipeCaloriesLabel.text    = "\(recipe.calories ?? 0)"
    } //: UPDATE VIEWS
    
    
    //MARK: - ACTIONS
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        
    } //: FAVORITE BUTTON
    
} //: CLASS
