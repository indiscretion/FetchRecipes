//
//  RecipesListViewModel.swift
//  FetchRecipes
//
//  Created by Cornelius Coachman on 1/27/25.
//

import Foundation

@MainActor class RecipesListViewModel: ObservableObject {
    
    @Published var recipes: [Recipe] = []
    
    func getAllRecipes(urlType: Recipe.RecipeURLStringType) {
        let urlString = ""
        
        guard let url = URL(string: urlString.getRecipeURLString(urlType: urlType)) else { return }
        
        URLSession.shared.fetchRecipeData(for: url) { (result: Result<Recipes, Error>) in
            switch result {
            case .success(let recipe):
                DispatchQueue.main.async {
                    print(recipe)
                    self.recipes = recipe.recipes
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
