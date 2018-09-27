//
//  Episode.swift
//  Assignment2
//
//  Created by Joshua Aaron Flores Stavedahl on 9/26/18.
//  Copyright © 2018 Northern Illinois University. All rights reserved.
//

import Foundation

struct EpisodeImage: Decodable {
    let medium: String
    let original: String
}

struct Episode: Decodable {
    let name: String
    let season: Int
    let number: Int
    let airdate: String
    let image: EpisodeImage
    let summary: String
}

struct EpisodeData: Decodable {
    let episodes: [Episode]
}

struct ShowData: Decodable {
    let name: String
    let summary: String
    let embedded: EpisodeData
    
    private enum CodingKeys: String, CodingKey {
        case name
        case summary
        case embedded = "_embedded"
    }
}



