//
//  Character.swift
//  Rick and Morty Codable
//
//  Created by Briana Bayne on 6/22/23.
//

import Foundation
// Using a struct becasue it is a value type and it's always best pratice to use value types over refernce types. Structs have build in initializers so all we need is the properties we are wanting to pull from the api.
// Adoping the decodable protocol
struct TopLevelDictonary: Decodable {
    // Using coding keys to match the API, I changed results to characters becasue its better name usage and since we are using result in our fetch, it wont have any issues when creating it.
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
