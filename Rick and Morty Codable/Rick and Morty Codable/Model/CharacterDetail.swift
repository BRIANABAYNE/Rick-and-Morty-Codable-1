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
        case status
        case characterName = "name"
        case gender
        case species
    }
    
    let id: Int
    let status: String 
    let characterName: String
    let gender: String
    let species: String

}

