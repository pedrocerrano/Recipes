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
    
    init() {
        load()
    }
    
    //MARK: - CRUD FUNCTIONS
    func createCategory(with name: String) {
        let newCategory = RecipeCategory(title: name)
        categories.append(newCategory)
        
        save()
    } //: CREATE
    

    func updateCategory(categoryToUpdate: RecipeCategory, newTitle: String) {
        categoryToUpdate.title = newTitle
        
        save()
    } //: UPDATE
    

    func deleteCategory(category categoryToDelete: RecipeCategory) {
        guard let categoryIndex = categories.firstIndex(of: categoryToDelete) else { return }
        categories.remove(at: categoryIndex)
        
        save()
    } //: DELETE
    
    
    private var fileURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let finalURL = documentsDirectory.appendingPathComponent("recipes.json")
        
        return finalURL
    } //: COMPUTED PROPERTY

    
    func save() {
        guard let url = fileURL else { return }
        do {
            let data = try JSONEncoder().encode(categories)
            try data.write(to: url)
        } catch let error {
            print(error.localizedDescription)
        } //: DO-CATCH
    } //: SAVE
    

    func load() {
        guard let url = fileURL else { return }
        do {
            let retreivedData       = try Data(contentsOf: url)
            let decodedCategories   = try JSONDecoder().decode([RecipeCategory].self, from: retreivedData)
            self.categories         = decodedCategories
        } catch let error {
            print(error.localizedDescription)
        } //: DO-CATCH
    } //: LOAD
    
} //: CLASS
