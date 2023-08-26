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
    // Waiting to receieve a value since they are optional
    var characterDetailSentViaSegue: CharacterDetailDict? {
        didSet { // property observor / Will feel confindent that the image was already set from the talbleView Controller in the fetchCharacter Data -
            updateView() // Dont want the view to update until I have a characterDetailSentViaSegue, that's where the didSet comes into play
        }
    }
    var characterImageSentViaSegue: UIImage?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Functions
    func updateView() {
        // guarding the optionals with guard
        guard let unrapedCharacterDetailDict = characterDetailSentViaSegue,
              let unrapedCharacterImage = characterImageSentViaSegue else { return }
        // All UI updates happen on the main thread.
        DispatchQueue.main.sync { // all UI changes on main thread. Updating
            self.characterStatusLabel.text = unrapedCharacterDetailDict.status
            self.characterNameLabel.text = unrapedCharacterDetailDict.characterName
            self.characterIDLabel.text = "\(unrapedCharacterDetailDict.id)" // string interpolation becasue ID is an INT. 
            self.characterImage.image = unrapedCharacterImage
            self.characterGenderLabel.text = unrapedCharacterDetailDict.gender
            self.characterSpecies.text = unrapedCharacterDetailDict.species
        }
    }
}
