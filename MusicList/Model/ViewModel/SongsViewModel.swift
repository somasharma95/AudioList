//
//  SongsViewModel.swift
//  MusicList
//
//  Created by Apple on 22/01/22.
//

import Foundation
import CoreData
import UIKit

enum SongState {
    case download
    case downloading
    case pause
    case play
}


final class SongsViewModel {
    
    var songs : Songs?
    var downloadedSongs : [String] = []
    var musicDictionary = [String:Data]()
    var songState : SongState = .download
    var song: String?
    
    func getSongs(completion : @escaping (Bool)->Void) {
        NetworkManager.getSongs { [weak self] result  in
            switch result {
            case .success(let songs):
                self?.songs = songs
                completion(true)
                
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func getNumberOfRows() -> Int {
        return songs?.data.count ?? 0
    }
    
    func getData(index:IndexPath) -> SongInfo? {
        return songs?.data[index.row]
    }
    
    func getPosition(_ song: String) -> Int? {
        return songs?.data.firstIndex(where: {$0.audioURL == song})
       }
}


