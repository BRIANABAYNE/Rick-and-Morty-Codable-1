//
//  NetworkingController.swift
//  Rick and Morty Codable
//
//  Created by Briana Bayne on 6/22/23.
//

import Foundation
import UIKit.UIImage

@available(iOS 16.0, *)


struct NetworkingController {

    // fetching the character data with a searchTerm that the user will be typing into the searchBar. I am asking for two different results, either TopLevelDict or an ResultError. The topLevelDict is the dictonary that we created from our model.
    func fetchCharacter(with searchTerm: String, completion: @escaping (Result<TopLevelDictonary, ResultError>) -> Void) {
        // Building the base URL - Adding the guard since I am initializing a URL from a string and that will return an optional. If URL can't be create, there is no passing.
        guard let baseURL = URL(string: "https://rickandmortyapi.com/api/") else {completion(.failure(.invalidURL)); return}
        // Creating the URL
        var urlRequest = URLRequest(url: baseURL)
        //Creating a urlRequest and assiging a URL request object initialized - URLRequest encapsulates two essential properties of a load request: the URL to load and the policies used to load it. In addition, for HTTP and HTTPS requests, URLRequest includes the HTTP method (GET, POST, and so on) and the HTTP headers. Can git and post with URLRequst.
        urlRequest.url?.append(path: searchTerm)
        // Appending the path of the URLRequst, had to make the urlRequst a var since we are changing it.
        print(urlRequest.url)
        // Asking to print the URL in the debugger for testing purpuse only, very helpful when using break points to assure the URL looks correct.        // DATA Task
        URLSession.shared.dataTask(with: urlRequest) { characterData, characterResponse, error in
            // Asking for a URL request data type "with urlRequest"
            if let error {
                // If failure - return out of the fetch function
                completion(.failure(.thrownError(error))); return
            }
            // If there is no response, check the URL. == nil will failure. 
            if characterResponse == nil {
                completion(.failure(.noResponse)); return
                
            }
            // If this guard fails, it will complete with a failure of noData and return out of the function.
            guard let characterData else {completion(.failure(.noData)); return}
            do {
                // Trying to decode our data from our model with the TopLevelDict from characterData with a JSON Decorder initialzed.
                let toplevelDict = try JSONDecoder().decode(TopLevelDictonary.self, from: characterData)
                completion(.success(toplevelDict))
                print("Lets f*cking go!!") // will print if sucessful with the decoding from our model from the information that we got from the API.
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume() // Will return to or begin again after
    } // end of Character
    // Fetching the image - Want to complete with two results, an UUIameg or a Error.
    func fetchImage(with character: Character, completion: @escaping (Result<UIImage, ResultError>) -> Void) {
        // The image from the API is a string
        guard let characterImageString = character.characterImage,
              let imageURL = URL(string:characterImageString) else { return }
   
        // Data Task want to complete with imageData or an error
        URLSession.shared.dataTask(with: imageURL) { imageData, _, error in
            
            if let error {
                completion(.failure(.thrownError(error))); return
                
            }
            guard let imageData else {completion(.failure(.noData)); return}
            
            guard let characterImage = UIImage(data: imageData) else {completion(.failure(.unableToDecode)); return }
            completion(.success(characterImage))
            
        }.resume()
    }// end of fetchImage
             // Fetching the characterDetails with an ID for the details of a single character that will display on the detail scree.
            func fetchCharacterDetail(for id: Int, completion: @escaping (Result<CharacterDetailDict, ResultError>) -> Void ) {
                guard let baseURL = URL(string: "https://rickandmortyapi.com/api/character") else
                { completion(.failure(.invalidURL)); return}
                var urlRequest = URLRequest(url: baseURL)
                // Appending a string interpolation - Turining an INT into a stirng / Path only takes a string
                urlRequest.url?.append(path: "\(id)")
    
                URLSession.shared.dataTask(with: urlRequest) { characterDetailData, _, characterDetailError in
    
                    if let characterDetailError {
                        completion(.failure(.thrownError(characterDetailError))); return
                    }
    
                    guard let characterDetailData else { completion(.failure(.noData)); return }
    
                    do { // Do, try, catch = data task - URL Session
                        let characterDetailDict = try JSONDecoder().decode(CharacterDetailDict.self, from: characterDetailData)
                        completion(.success(characterDetailDict))
                    } catch {
                        completion(.failure(.unableToDecode)); return
                    }
                }.resume()
            }
        }// end of characterDetails
