//
//  RecipesFavoriteView.swift
//  FetchRecipes
//
//  Created by Cornelius Coachman on 1/28/25.
//

import SwiftUI
import SwiftData

struct RecipesFavoriteView: View {
    @Environment(\.modelContext) private var context
    @State var isBookmarked = false
    @State private var searchText = ""

    @Query(sort: \SavedRecipe.name, order: .forward) private var savedRecipe: [SavedRecipe]
    
    var body: some View {
        List(savedRecipe) { recipe in
            Section {
                RecipeView(cuisineType: recipe.cuisine ?? "", cuisineName: recipe.name ?? "", cuisineLargeImage: recipe.photo_url_large ?? "", cuisineSmallImage: recipe.photo_url_small ?? "", youtubeURL: recipe.youtube_url ?? "")
            }
        }
        .navigationTitle("Favorites")
        .listSectionSpacing(.custom(10))
    }
}

struct RecipesFavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesFavoriteView()
    }
}
