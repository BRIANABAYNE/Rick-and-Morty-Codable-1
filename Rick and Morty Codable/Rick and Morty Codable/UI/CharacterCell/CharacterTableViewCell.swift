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
    //lables and UIImage from the cell on the tableview.
    @IBOutlet weak var characterNameLabel: UILabel!
   @IBOutlet weak var characterSpeciesLabel: UILabel!
   @IBOutlet weak var characterGenderLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    // MARK: - Properteis
    // creating a variable becasue I want it change - Dont want to assign the value now and that's why it's optional
    var characterToSendInSegue: Character?
    // Goal not fetch the image again, that's why I am making it of type UIImage
    var characterImageToSendInSegue: UIImage?
    
    // MARK: - Lifecycles
     override func prepareForReuse() {
        super.prepareForReuse()
        characterImage.image = nil
    }
    // MARK: - Functions
    // Function will take in character - updating the view with a character
    func updateView(character: Character) {
        // assigning the value of the optional propeties here (properties on line 23 and 25)
        characterToSendInSegue = character
        fetchImage(character:character)
    }
    
    func fetchImage(character: Character) {
       
        NetworkingController().fetchImage(with: character) { [weak self] result in
            switch result {
            case.success(let path): // the value the clousre successfully compeleted with . path is UIImage 
                DispatchQueue.main.async { // All UI changes on the main thread. 
                    self?.characterToSendInSegue = character
                    self?.characterImageToSendInSegue = path
                    self?.characterImage.image = path
                    self?.characterNameLabel.text = character.name
                   self?.characterGenderLabel.text = character.gender
                   self?.characterSpeciesLabel.text = "\(character.species)"
                 
                }
            case.failure(let failure):
                print(failure.errorDescription!)
            }
        }
    }
}
