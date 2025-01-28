//
//  EmptyRecipeView.swift
//  FetchRecipes
//
//  Created by Cornelius Coachman on 1/27/25.
//

import SwiftUI

struct EmptyRecipeView: View {
    var body: some View {
        VStack {
            Text("No recipes are available")
                .font(.title3)
                .bold()
                .lineLimit(2)
            Image(systemName: "fork.knife.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundColor(.black)
                .symbolEffect(.bounce.down, isActive: true)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EmptyRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyRecipeView()
    }
}
