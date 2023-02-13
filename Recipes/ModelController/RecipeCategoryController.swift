//
//  RecipeCategoryController.swift
//  Recipes
//
//  Created by iMac Pro on 2/13/23.
//

import Foundation

class RecipeCategoryController {
    
    static let sharedInstance = RecipeCategoryController()
    var categories: [RecipeCategory] = []
    
    //MARK: - CRUD FUNCTIONS
    func createCategory(with name: String) {
        let newCategory = RecipeCategory(title: name)
        categories.append(newCategory)
        
        save()
    } //: CREATE
    

    func update(categoryToUpdate: RecipeCategory, newTitle: String) {
        categoryToUpdate.title = newTitle
        
        save()
    } //: UPDATE
    

    func delete(category categoryToDelete: RecipeCategory) {
        guard let categoryIndex = categories.firstIndex(of: categoryToDelete) else { return }
        categories.remove(at: categoryIndex)
        
        save()
    } //: DELETE
    

    func save() {
        
    } //: SAVE
    

    func load() {
        
    } //: LOAD
    
} //: CLASS
