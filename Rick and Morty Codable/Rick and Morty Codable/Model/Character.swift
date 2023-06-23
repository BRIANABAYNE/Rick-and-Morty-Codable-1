//
//  Character.swift
//  Rick and Morty Codable
//
//  Created by Briana Bayne on 6/22/23.
//

import Foundation

struct TopLevelDictonary: Decodable  {
    
private enum CodingKeys: String, CodingKey {
        case character = "results"
}
    
let characters: [Character]

struct Character: Decodable {
    private enum CodingKeys: String, CodingKey {
        case characterImage = "image"
        
    }

    }
        
    let name: String
    let species: String
    let gender: String
    let characterImage: String
   
}

