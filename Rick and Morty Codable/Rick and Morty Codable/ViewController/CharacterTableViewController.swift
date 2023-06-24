//
//  CharacterTableViewController.swift
//  Rick and Morty Codable
//
//  Created by Briana Bayne on 6/22/23.
//

import UIKit
@available(iOS 16.0, *)
class CharacterTableViewController: UITableViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var characterSearchBar: UISearchBar!
    
    
    // MARK: - Properties
    
    var tld: TopLevelDictonary?
    
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterSearchBar.delegate = self
    }
    
    // MARK: - Table view data source
    
    
}

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return tld?.characters.count ?? 0
}


override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as?
            CharacterTableViewCell else { return UITableViewCell() }
    guard let character = tld?.characters[indexPath.row] else { return UITableViewCell()}
    cell.updateView(character: character)
    return cell
    
    
}

override func prepare(for segue: UIStoryboardSegue, sender: Any? ) {
    
    guard segue.identifier == "toDetailVC",
          let indexPath = tableView.indexPathForSelectedRow,
          let cell = tableView.cellForRow(at: indexPath) as? CharacterTableViewCell,
          let destination = segue.destination as? CharacterDetailViewController,
          let character = cell.characterToSendInSegue else { return }
    
    
    let characterImage = cell.characterToSendInSegue
    
    NetworkingController().fetchCharacterDetail(for: character.id) { result in
        switch result {
        case.success(let characterDetailDict):
            destination.characterToSendInSegue = characterImage
            destination.characterDetailSentViaSegue = characterDetailDict
        case.failure( let error):
            print("Oh no, it's an error!!!!", error.errorDescription!)
            
        }
        
    }
}




@available(iOS 16.0, *)
extension CharacterTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar ) {
        
        guard let searchTerm = searchBar.text else { return }
        
        
        NetworkingController().fetch(endpoint: "character", with: searchTerm) { [weak self] result in
            switch result {
            case.success(let tld):
                DispatchQueue.main.async {
                    self?.tld = tld
                    self?.tableView.reloadData()
                }
            case.failure(let error):
                print(error.errorDescription!)
            }
            
            
        }
        searchBar.resignFirstResponder()
        
        
    }
    
}




9
