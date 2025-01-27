//
//  RecipesListView.swift
//  FetchRecipes
//
//  Created by Cornelius Coachman on 1/27/25.
//

import SwiftUI
import SwiftData

struct RecipesListView: View {
    @Environment(\.modelContext) private var context
    @ObservedObject var recipesListViewModel = RecipesListViewModel()
    
    @State private var searchText = ""
    @Query(sort: \SavedRecipe.name, order: .reverse) private var savedRecipe: [SavedRecipe]

    var filteredRecipes: [Recipe] {
        if searchText.isEmpty || searchText.count < 2 {
            recipesListViewModel.recipes
        } else {
            recipesListViewModel.recipes.filter {
                $0.name.localizedStandardContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredRecipes) { recipesArray in
                Section {
                    RecipeView(cuisineType: recipesArray.cuisine, cuisineName: recipesArray.name, cuisineLargeImage: recipesArray.photo_url_large ?? "", cuisineSmallImage: recipesArray.photo_url_small ?? "", youtubeURL: recipesArray.youtube_url ?? "", isBookmarked: false)
                }
            }
            .listSectionSpacing(.custom(10))
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText)
            .onAppear {
                recipesListViewModel.getAllRecipes(urlType: .success)
            }
        }
    }
}
