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
    @State var showAlert = false
    @State private var animate = false
    @State private var searchText = ""
    @State var isEmpty = false

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
            if isEmpty {
                VStack {
                    Spacer()
                    EmptyRecipeView()
                    Spacer()
                }
            }
            
            List(filteredRecipes) { recipesArray in
                Section {
                    RecipeView(cuisineType: recipesArray.cuisine, cuisineName: recipesArray.name, cuisineLargeImage: recipesArray.photo_url_large ?? "", cuisineSmallImage: recipesArray.photo_url_small ?? "", youtubeURL: recipesArray.youtube_url ?? "", isBookmarked: false)
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
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText)
            .onAppear {
                showAlert = true
            }
        }

    }
    
    func showActionSheet() -> ActionSheet {
        return ActionSheet(title: Text("Select a Type"), buttons: [
            .default(Text("Success")) {
                recipesListViewModel.getAllRecipes(urlType: .success)
                withAnimation {
                    isEmpty = recipesListViewModel.hasValues
                }
            },
            .default(Text("Malformed")) {
                recipesListViewModel.getAllRecipes(urlType: .malformed)
                withAnimation {
                    isEmpty = recipesListViewModel.hasValues
                }
            },
            .default(Text("Empty")) {
                recipesListViewModel.getAllRecipes(urlType: .empty)
                withAnimation {
                    isEmpty = recipesListViewModel.hasValues
                }
            }])
    }
}
