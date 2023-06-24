//
//  CharacterTableViewCell.swift
//  Rick and Morty Codable
//
//  Created by Briana Bayne on 6/22/23.
//

import UIKit

@available(iOS 16.0, *)

class CharacterTableViewCell: UITableViewCell {
    
    
    // MARK: - Outlets
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterSpeciesLabel: UILabel!
    @IBOutlet weak var characterGenderLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    
    // MARK: - Properteis
    var characterToSendInSegue: Character?
    var characterImageToSendInSegue: UIImage?
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImage.image = nil
    }
    
    
}


func updateView(character: Character) {
    
    characterToSendInSegue = character
    fetchImage(character:character)
    
}


func fetchImage(character: Character) {
    guard let characterImage = character.characterImage else { return }
    NetworkingController().fetchImage(with: character) { [weak self] result in
        switch result {
        case.success(let path):
            DispatchQueue.main.async {
                self?.characterToSendInSegue = path
                self?.characterImage.image = path
                self?.characterNameLabel.text = character.name
                self?.characterGenderLabel.text = character.gender
                self.characterSpeciesLabel.text = "\(character.specicesLabel)"
                
                
            }
        case.failure(let failure):
            print(failure.errorDescription)
        }
    }
    
    
    
    
}



