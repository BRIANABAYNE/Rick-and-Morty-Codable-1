//
//  Character.swift
//  Rick and Morty Codable
//
//  Created by Briana Bayne on 6/22/23.
//

import Foundation

struct TopLevelDictonary: Decodable  {
    
    let results: [Result]
}

struct Result: Decodable {
    

    let name: String
    let species: String
    let gender: String
    let image: String
   
}

