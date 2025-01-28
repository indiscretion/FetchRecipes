//
//  RecipeView.swift
//  FetchRecipes
//
//  Created by Cornelius Coachman on 1/27/25.
//

import SwiftUI

struct RecipeView: View {
    var cuisineType: String
    var cuisineName: String
    var cuisineLargeImage: String
    var cuisineSmallImage: String
    var youtubeURL: String
    var isBookmarked: Bool = false
    
    var body: some View {
            HStack {
                AsyncImage(url: URL(string: cuisineLargeImage)) { result in
                    
                    result.image?
                        .resizable()
                        .scaledToFit()
                    
                }
                .frame(width: 50, height: 50)
                
                VStack(alignment: .leading) {
                    Text(cuisineName)
                        .font(.headline)
                        .bold()
                        .lineLimit(2)
                    
                    Text(cuisineType)
                        .font(.subheadline)
                        .lineLimit(2)
                }
                Spacer()
                
                VStack {
                    Image(systemName: "bookmark.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.blue)
                    .opacity(isBookmarked ? 1 : 0)
                    
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(cuisineType: "Malaysian", cuisineName: "Apam Balik", cuisineLargeImage: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg", cuisineSmallImage: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg", youtubeURL: "", isBookmarked: false)
    }
}
