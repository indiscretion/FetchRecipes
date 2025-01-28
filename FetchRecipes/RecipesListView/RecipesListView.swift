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
    
    // MARK: STATE VARIABLES
    @State var showAlert = false
    @State private var animate = false
    @State private var searchText = ""
    @State var isEmpty = false
    @State var isBookmarked = false
    
    // MARK: QUERY
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
    
    // MARK: VIEW
    var body: some View {
        NavigationStack {
            if isEmpty {
                VStack {
                    Spacer()
                    EmptyRecipeView()
                    Spacer()
                }
            }
            
            List(filteredRecipes) { recipe in
                Section {
                    RecipeView(cuisineType: recipe.cuisine, cuisineName: recipe.name, cuisineLargeImage: recipe.photo_url_large ?? "", cuisineSmallImage: recipe.photo_url_small ?? "", youtubeURL: recipe.youtube_url ?? "", isBookmarked: checkIfBookmarked(recipeName: recipe.name))
                        .contentShape(Rectangle())
                        .onTapGesture {
                            checkIfBookmarked(recipeName: recipe.name) == true ? (isBookmarked = false) : (isBookmarked = true)
                            
                            isBookmarked ? saveRecipe(recipeInfo: recipe, isBookmarked: isBookmarked) : deleteRecipe(recipeInfo: recipe)
                        }
                }
            }
            .toolbar {
                Button {
                    animate.toggle()
                    showAlert = true
                } label: {
                    Image(systemName: "link.circle")
                        .symbolEffect(.bounce.down, value: animate)
                        .font(.title)
                }
            }
            .actionSheet(isPresented: $showAlert){
                showActionSheet()
            }
            .listSectionSpacing(.custom(10))
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText)
            .onAppear {
                showAlert = true
            }
        }
        
    }
    
    // MARK: ACTION SHEET
    func showActionSheet() -> ActionSheet {
        return ActionSheet(title: Text("Select a Type"), buttons: [
            .default(Text("Success")) {
                recipesListViewModel.getAllRecipes(urlType: .success)
                withAnimation {
                    isEmpty = false
                }
            },
            .default(Text("Malformed")) {
                recipesListViewModel.getAllRecipes(urlType: .malformed)
                withAnimation {
                    isEmpty = true
                }
            },
            .default(Text("Empty")) {
                recipesListViewModel.getAllRecipes(urlType: .empty)
                withAnimation {
                    isEmpty = true
                }
            },
            .cancel()])
    }
    
    // MARK: BOOKMARK CHECK
    func checkIfBookmarked(recipeName: String) -> Bool {
        for recipe in savedRecipe {
            if recipe.isBookmarked && recipe.name == recipeName {
                return true
            }
        }
        return false
    }
    
    // MARK: SWIFT DATA
    func saveRecipe(recipeInfo: Recipe, isBookmarked: Bool) {
        let savedCountry = SavedRecipe(uuid: recipeInfo.uuid, cuisine: recipeInfo.cuisine, name: recipeInfo.name, photo_url_large: recipeInfo.photo_url_large, photo_url_small: recipeInfo.photo_url_small, source_url: recipeInfo.source_url, youtube_url: recipeInfo.youtube_url, isBookmarked: isBookmarked)
        
        context.insert(savedCountry)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteRecipe(recipeInfo: Recipe) {
        let recipeName = recipeInfo.name
        
        do {
            try context.delete(model: SavedRecipe.self, where: #Predicate<SavedRecipe> { recipe in
                recipe.name == recipeName
            })
        } catch {
            print(error.localizedDescription)
        }
    }
}
