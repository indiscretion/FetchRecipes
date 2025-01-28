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
    @State var hasFavorites = false

    @State private var searchText = ""
    @Environment(\.openURL) private var openURL
    
    @Query(sort: \SavedRecipe.name, order: .forward) private var savedRecipe: [SavedRecipe]
    
    var body: some View {
        if savedRecipe.isEmpty {
            EmptyRecipeView()
        } else {
            List(savedRecipe) { recipe in
                Section {
                    RecipeView(cuisineType: recipe.cuisine ?? "", cuisineName: recipe.name ?? "", cuisineLargeImage: recipe.photo_url_large ?? "", cuisineSmallImage: recipe.photo_url_small ?? "", youtubeURL: recipe.youtube_url ?? "", isFavorite: true)
                        .onTapGesture {
                            openURL(URL(string: recipe.youtube_url ?? "") ?? URL(fileURLWithPath: ""))
                        }
                }
            }
            .navigationTitle("Favorites")
            .listSectionSpacing(.custom(10))
            .onAppear {
                hasFavorites = savedRecipe.isEmpty
            }
        }
    }
}

struct RecipesFavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesFavoriteView()
    }
}
