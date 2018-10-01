//
//  Episode.swift
//  Assignment2
//
//  Created by Joshua Aaron Flores Stavedahl on 9/26/18.
//  Copyright © 2018 Northern Illinois University. All rights reserved.
//

import Foundation

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

/*class MusicImage: MusicTop {
    var __text: String
    //let original: String
    
    override init(__text: String) {
        self.__text = __text
    }
}*/

class MusicTop {
    var title: String
    var updated: String
    var image: String
    
    init(title: String, updated: String, image: String) {
        self.title = title
        self.updated = updated
        self.image = image
    }
}



