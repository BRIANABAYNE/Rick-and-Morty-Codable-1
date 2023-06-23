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
    
    // url
    // data task
    // decode data
    
    func fetch(with searchTerm: String, completion: @escaping (Result<TopLevelDictonary, ResultError>) -> Void) {
        guard let baseURL = URL(string: "https://rickandmortyapi.com/api/character") else {completion(.failure(.invalidURL)); return}
        
        var urlRequest = URLRequest(url:baseURL)
        urlRequest.url?.append(path: endPoint)
        print(urlRequest.url)
        
        URLSession.shared.dataTask(with: urlRequest) { characterData, characterResponse, error in
            
            if let error {
                completion(.failure(.thrownError(error))); return
            }
            if characterResponse == nil {
                completion(.failure(.noResponse)); return
                
            }
            guard let characterData else {completion(.failure(.noData)); return}
            do {
                
                let toplevelDict = try JSONDecoder().decode(TopLevelDictonary, from: characterData)
                completion(.success(toplevelDict))
                print("Lets f*cking go!!")
            } catch {
                completion(.failure(.thrownError(error)))
            }
            
        }.resume()
        
        
    }
    
    func fetchImage(with image: Character, completion: @escaping (Result<UIImage, ResultError) -> Void) {
        
        guard let imageURL = URL(string: characterImage) else { return }
        
        URLSession.shared.dataTask(with: imageURL) { imageData, _, error in
            
            if let error {
                completion(.failure(.thrownError(error))); return
                
            }
            guard let imageData else {completion(.failure(.noData)); return}
            guard let image = UIImage(data: imageData) else {completion(.failure(.unableToDecode));
                return }
                
                completion(.success(image))
        }.resume()
            
        
        
        
    }
    
    
    
    
    
    
    
    
    
}
