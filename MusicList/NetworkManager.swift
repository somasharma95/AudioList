//
//  NetworkManager.swift
//  MusicList
//
//  Created by Apple on 22/01/22.
//

import Foundation

enum NetworkError : Error {
    case domainError
    case decodingError
}

struct Constants {
    static let url = "https://gist.githubusercontent.com/Lenhador/a0cf9ef19cd816332435316a2369bc00/raw/538f2a020253263e242ead7e8cb9f9a1f965f2e6/Songs.json"
}

class NetworkManager {
    
    static func getSongs(completion : @escaping (Result<Songs, NetworkError>) -> Void) {
        
        guard let url = URL(string: Constants.url) else {
            return
        }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            do {
            let songs = try JSONDecoder().decode(Songs.self, from: data)
                completion(.success(songs))
            }
            catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    
}



