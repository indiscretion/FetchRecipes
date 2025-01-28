//
//  RecipesMainView.swift
//  FetchRecipes
//
//  Created by Cornelius Coachman on 1/28/25.
//

import SwiftUI

struct RecipesMainView: View {
    var body: some View {
        NavigationStack {
            TabView {
                NavigationView {
                    RecipesListView()
                }
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
                
                NavigationView {
                    RecipesFavoriteView()
                }
                .tabItem { Label("Favorites", systemImage: "star") }
            }
        }
    }
}

struct CountriesMainView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesMainView()
    }
}
