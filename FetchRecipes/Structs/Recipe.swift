//
//  Recipe.swift
//  FetchRecipes
//
//  Created by Cornelius Coachman on 1/27/25.
//

import Foundation

struct Recipe: Decodable, Identifiable {
    var id = UUID().uuidString
    
    let cuisine: String
    let name: String
    var photo_url_large: String? = nil
    var photo_url_small: String? = nil
    let uuid: String
    var source_url: String? = nil
    var youtube_url: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photo_url_large
        case photo_url_small
        case uuid
        case source_url
        case youtube_url
    }
}
