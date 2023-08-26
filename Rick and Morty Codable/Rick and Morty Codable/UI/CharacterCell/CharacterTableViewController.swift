//
//  CharacterTableViewController.swift
//  Rick and Morty Codable
//
//  Created by Briana Bayne on 6/22/23.
//

import UIKit

class CharacterTableViewController: UITableViewController {
    
    // MARK: - Outlets
    //UI SearchBar
    @IBOutlet weak var characterSearchBar: UISearchBar!
    
    // MARK: - Properties
    // Creating a constant tld: of type TopeLevelDict.
    // Making this optional becasue I will only get the value to this once I have sucessfully fetched it.
    var tld: TopLevelDictonary?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        characterSearchBar.delegate = self // confirming to the delegate.
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // From the TopLoveDict, the characters and returning the count. Nil coalescing, I want this or I just want zero.
        return tld?.characters.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as?
                CharacterTableViewCell else { return UITableViewCell() } // return a basic b if we can't have a CharacterTableViewCell.
        guard let character = tld?.characters[indexPath.row] else { return UITableViewCell() }
        cell.updateView(character: character)
        return cell
    }
    // Will send data with a segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any? ) {
       // What Segue was triggered, what cell, what destination is the segue going to go to, then what data do you want to send. Identifer is the property of a segue.
        guard segue.identifier == "toDetailVC",
              let indexPath = tableView.indexPathForSelectedRow,
              let cell = tableView.cellForRow(at: indexPath) as? CharacterTableViewCell,
              let destination = segue.destination as? CharacterDetailViewController,
              let character = cell.characterToSendInSegue else { return }
        
        // What I want to send in the segue. Fetch the details of the character that the user has selected. Destination.image = cell.characterToSendInSegue
        let charImage = cell.characterImageToSendInSegue // the value and assiging to charImage
        
        NetworkingController().fetchCharacterDetail(for:character.id) { result in
            switch result {
            case .success(let characterDetailDict):
                destination.characterImageSentViaSegue = charImage // Need to send the image first or the data wont show - Both will be set at the same time. 
                destination.characterDetailSentViaSegue = characterDetailDict
            case .failure(let error):
                print("Oh no, it's an error!", error.errorDescription)
            }
            
            }
        }
    }
// MARK: - Extension
@available(iOS 16.0, *)
// Extension and adopted the UISearchBarDelegate
extension CharacterTableViewController: UISearchBarDelegate {
    // Function will trigger when the user hits enter
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar ) {
        
        // Guarding becasue it's optional
        guard let searchTerm = searchBar.text else { return }
        // Initialzing a networking controller and fetching chatacter
        NetworkingController().fetchCharacter(with: "character") { [weak self] result in
            switch result {
            case.success(let tld):
                DispatchQueue.main.async { // all UI changes are on the main thread.
                    self?.tld = tld
                    self?.tableView.reloadData() // I need to call this becasue viewWillLoad only happens when the app launces and I need the view to reload once the user types in a character.
                }
            case.failure(let error):
                print(error.errorDescription!)
            }
        }
        searchBar.resignFirstResponder()
    }
}
