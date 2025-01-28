//
//  FetchRecipesApp.swift
//  FetchRecipes
//
//  Created by Cornelius Coachman on 1/27/25.
//

import SwiftUI
import SwiftData

@main
struct FetchRecipesApp: App {
    var body: some Scene {
        WindowGroup {
            RecipesMainView()
        }.modelContainer(for: SavedRecipe.self)
    }
}
