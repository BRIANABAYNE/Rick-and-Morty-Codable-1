//
//  CharacterDetailViewController.swift
//  Rick and Morty Codable
//
//  Created by Briana Bayne on 6/23/23.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    
    // MARK: - Outlets
    
    
    @IBOutlet weak var characterOrginLabel: UILabel!
    @IBOutlet weak var characterTypeLabel: UILabel!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterIDLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    
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
        
        // Do any additional setup after loading the view.
    }
    
    
    func updateView() {
        guard let unrapedCharacterDetailDict = characterDetailSentViaSegue,
              let unrapedCharacterImage = characterImageSentViaSegue else { return }
        
        
        DispatchQueue.main.sync {
            
            self.characterOrginLabel.text = "\(unrapedCharacterDetailDict.origin)"
            self.characterTypeLabel.text = unrapedCharacterDetailDict.type
            self.characterNameLabel.text = unrapedCharacterDetailDict.characterName
            self.characterIDLabel.text = "\(unrapedCharacterImage)"
            self.characterImage.image = unrapedCharacterImage
            
            
            
            
            
            
        }
        
        
        
        
    }
    
    
   
}
