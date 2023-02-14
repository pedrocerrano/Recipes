//
//  RecipeTableViewCell.swift
//  Recipes
//
//  Created by iMac Pro on 2/14/23.
//

import UIKit

protocol RecipeTableViewCellDelegate: AnyObject {
    func toggleFavoriteButtonTapped(cell: RecipeTableViewCell)
} //: PROTOCOL

class RecipeTableViewCell: UITableViewCell {

    //MARK: - OUTLETS
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeCaloriesLabel: UILabel!
    @IBOutlet weak var recipeFavoriteButton: UIButton!
    
    
    //MARK: - PROPERTIES
    weak var delegate: RecipeTableViewCellDelegate?
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
        
        let favoriteImageName = recipe.isFavorite ? "star.fill" : "star"
        let favoriteImage = UIImage(systemName: favoriteImageName)
        recipeFavoriteButton.setImage(favoriteImage, for: .normal)
    } //: UPDATE VIEWS
    
    
    //MARK: - ACTIONS
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        delegate?.toggleFavoriteButtonTapped(cell: self)
    } //: FAVORITE BUTTON
    
} //: CLASS
