//
//  SavedRecipe.swift
//  FetchRecipes
//
//  Created by Cornelius Coachman on 1/27/25.
//

import SwiftData

@Model
class SavedRecipe: Identifiable {
    @Attribute(.unique) var uuid: String
    var cuisine: String?
    var name: String?
    var photo_url_large: String?
    var photo_url_small: String?
    var source_url: String?
    var youtube_url: String?
    var isBookmarked: Bool
    
    init(uuid: String, cuisine: String? = nil, name: String? = nil, photo_url_large: String? = nil, photo_url_small: String? = nil, source_url: String? = nil, youtube_url: String? = nil, isBookmarked: Bool) {
        self.uuid = uuid
        self.cuisine = cuisine
        self.name = name
        self.photo_url_large = photo_url_large
        self.photo_url_small = photo_url_small
        self.source_url = source_url
        self.youtube_url = youtube_url
        self.isBookmarked = isBookmarked
    }
}
