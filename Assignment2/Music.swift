//
//  Episode.swift
//  Assignment2
//
//  Created by Joshua Aaron Flores Stavedahl on 9/26/18.
//  Copyright © 2018 Northern Illinois University. All rights reserved.
//

import Foundation

struct MusicImage: Decodable {
    let medium: String
    let original: String
}

struct MusicData: Decodable {
    let title: String
}

struct Episode: Decodable {
    let entry: [MusicData]
    //let name: String
    //let season: Int
    //let number: Int
    //let airdate: String
    //let image: MusicImage
    //let summary: String
}

struct Feed: Decodable {
    let feed: Episode
}

struct ShowData: Decodable {
    let object: Feed
    let title: String
    
    private enum CodingKeys: String, CodingKey {
        case object = "object"
        case title
    }
}

class MusicTop {
    var title: String
    var updated: String
    
    init(title: String, updated: String) {
        self.title = title
        self.updated = updated
    }
}



