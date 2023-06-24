//
//  CharacterDetail.swift
//  Rick and Morty Codable
//
//  Created by Briana Bayne on 6/23/23.
//

import Foundation


struct CharacterDetailDict: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case characterName = "name"
        case type
        case origin
        
    }
    
    let id: Int
    let characterName: String
    let type: String
    let origin: [Origin]

}
struct Origin: Decodable {
    private enum CodingKeys: String, CodingKey {
        case nameLocation = "name"
    }
    
    let nameLocation: String
    
}
