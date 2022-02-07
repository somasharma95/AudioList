//
//  Songs.swift
//  MusicList
//
//  Created by Apple on 22/01/22.
//

import Foundation


// MARK: - Songs
struct Songs: Codable {
    let data: [SongInfo]
}

// MARK: - Datum
struct SongInfo: Codable, Equatable {
    let id, name: String?
    let audioURL: String?
}
