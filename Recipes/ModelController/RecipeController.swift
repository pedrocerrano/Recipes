//
//  RecipeController.swift
//  Recipes
//
//  Created by iMac Pro on 2/13/23.
//

import Foundation

class RecipeController {
    
    //MARK: - CRUD
    func createRecipe(category: RecipeCategory) {
        let newRecipe = Recipe(title: "Untitled Recipe", description: "Recipe Description", calories: 0, cookTime: 0)
        category.recipes.append(newRecipe)
        
        RecipeCategoryController.sharedInstance.save()
    } //: CREATE
    
    
    func updateRecipe(recipe: Recipe, newTitle: String, newDesc: String, newCal: Int, newCookTime: Int) {
        recipe.title        = newTitle
        recipe.description  = newDesc
        recipe.calories     = newCal
        recipe.cookTime     = newCookTime
        
        RecipeCategoryController.sharedInstance.save()
    } //: UPDATE
    
    
    func deleteRecipe(recipeToDelete: Recipe, from category: RecipeCategory) {
        guard let recipeIndex = category.recipes.firstIndex(of: recipeToDelete) else { return }
        category.recipes.remove(at: recipeIndex)
        
        RecipeCategoryController.sharedInstance.save()
    } //: DELETE
    
} //: CLASS
