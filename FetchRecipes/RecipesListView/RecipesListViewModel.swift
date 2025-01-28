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
        self.recipes = []
        
        guard let url = URL(string: String().getRecipeURLString(urlType: urlType)) else { return }
        
        URLSession.shared.fetchRecipeData(for: url) { (result: Result<Recipes, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let recipe):
                    self.recipes = recipe.recipes
                case .failure(_):
                    return
                }
                
            }
        }
    }
}
