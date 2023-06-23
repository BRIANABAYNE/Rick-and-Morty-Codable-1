//
//  CharacterTableViewCell.swift
//  Rick and Morty Codable
//
//  Created by Briana Bayne on 6/22/23.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    
    // MARK: - Outlets
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterSpeciesLabel: UILabel!
    @IBOutlet weak var characterGenderLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    
    
    // MARK: - Properties
    var character: Character?
    var image: UIImage
    
    func updateView(character:Character) {
        
        
        
    }
    
    func fetcImage(character:Character) {
        NetworkingController().fetchImage(with: character) { result in
            switch result {
            case.success(let image)
            }
        }
    }
    
    
    
    
}



