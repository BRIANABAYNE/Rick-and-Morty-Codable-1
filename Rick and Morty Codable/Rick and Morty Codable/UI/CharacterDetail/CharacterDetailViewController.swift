//
//  CharacterDetailViewController.swift
//  Rick and Morty Codable
//
//  Created by Briana Bayne on 6/23/23.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var characterStatusLabel: UILabel!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterIDLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterGenderLabel: UILabel!
    @IBOutlet weak var characterSpecies: UILabel!
    
    // MARK: - Properties
    
    var characterDetailSentViaSegue: CharacterDetailDict? {
        didSet {
            updateView()
        }
    }
    var characterImageSentViaSegue: UIImage?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Functions
    func updateView() {
        guard let unrapedCharacterDetailDict = characterDetailSentViaSegue,
              let unrapedCharacterImage = characterImageSentViaSegue else { return }
        
        DispatchQueue.main.sync { // Updating
            self.characterStatusLabel.text = unrapedCharacterDetailDict.status
            self.characterNameLabel.text = unrapedCharacterDetailDict.characterName
            self.characterIDLabel.text = "\(unrapedCharacterDetailDict.id)" // string interpolation becasue ID is an INT.
            self.characterImage.image = unrapedCharacterImage
            self.characterGenderLabel.text = unrapedCharacterDetailDict.gender
            self.characterSpecies.text = unrapedCharacterDetailDict.species
        }
    }
}
