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

    var filteredRecipes: [Recipes] {
        if searchText.isEmpty || searchText.count < 2 {
            recipesListViewModel.recipes
        } else {
            recipesListViewModel.recipes.filter {
                $0.recipes[0].name.localizedStandardContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
            }
            .listSectionSpacing(.custom(10))
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText)
            .onAppear {
                recipesListViewModel.getAllRecipes(urlType: .success)
            }
        }
    }
}
