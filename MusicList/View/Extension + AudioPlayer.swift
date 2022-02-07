//
//  Extension + AudioPlayer.swift
//  MusicList
//
//  Created by Apple on 24/01/22.
//

import Foundation
import AVFoundation

extension SongsViewController {
    
    func playAudio(url:String) {
        pauseAudio()
        guard let urlMusic = URL(string: url) else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            if let data = viewModel.musicDictionary[url] {
                player = try? AVAudioPlayer(data: data)
            }
            else {
                guard let data = try? Data(contentsOf: urlMusic) else {return}
            player = try? AVAudioPlayer(data: data)
            }
            guard let player = player else { return }
            player.prepareToPlay()
            player.volume = 1.0
            player.play()
            viewModel.song = url
            viewModel.songState = .play
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func pauseAudio() {
        player?.stop()
        self.viewModel.song = nil
    }
    
    func pauseCurrentlyPlaying() {
        if let currentSong = viewModel.currentlyPlaying() {
            pauseAudio()
            if let indexStop = viewModel.getPosition(currentSong) {
                let cell = viewLayout.tableView.cellForRow(at: IndexPath(item: indexStop, section: 0)) as! SongsTableViewCell
                viewLayout.setButtonUI(state: .play, actionBtn: cell.actionBtn)
            }
        }
    }
    
    
}
