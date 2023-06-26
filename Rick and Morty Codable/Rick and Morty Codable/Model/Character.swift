//
//  Character.swift
//  Rick and Morty Codable
//
//  Created by Briana Bayne on 6/22/23.
//

import Foundation

struct TopLevelDictonary: Decodable  {
    
    private enum CodingKeys: String, CodingKey {
        case characters = "results"
    }
    
    let characters: [Character]
}


struct Character: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case characterImage = "image"
        case name
        case gender
        case species
    }
    
    
    let id: Int
    let name: String
    let species: String
    let gender: String
    let characterImage: String?
}


