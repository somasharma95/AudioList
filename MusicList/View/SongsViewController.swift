//
//  SongsViewController.swift
//  MusicList
//
//  Created by Apple on 22/01/22.
//

import UIKit
import AVFoundation

final class SongsViewController: UIViewController {

    let viewModel : SongsViewModel = SongsViewModel()
    
    @IBOutlet var viewLayout: SongsViewLayout!
    private var selectedIndexPath = 0
    var player : AVAudioPlayer?
   fileprivate var isDownloaded:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        getSongs()
        self.title = ViewConstants.title
    }
    
    private func getSongs() {
        viewModel.getSongs { [weak self] isValid in
            if isValid {
                DispatchQueue.main.async {
                self?.viewLayout.tableView.reloadData()
                }
            }
            else {
                print("error")
            }
        }
    }
    
    
    
    @objc func buttonTapped(_ sender: UIButtonEnhanced) {
        var state = SongState.downloading
        if let index = viewLayout.getButtonIndexInTableView(tableView: viewLayout.tableView, view: sender),
           let song = viewModel.getData(index: index) {
            if viewModel.downloadedSongs.contains(song.audioURL ?? "") {
                state = .play
            }
            else {
                state = .download
            }
            guard let url = song.audioURL else {return}
            if state == .download {
                self.viewLayout.setButtonUI(state: .downloading, actionBtn: sender )
                    self.viewModel.downloadSong(url: url) { [weak self] isDownloaded in
                    if isDownloaded {
                        DispatchQueue.main.async {
                            self?.viewLayout.setButtonUI(state: .play, actionBtn: sender )
                    }
                    }
                }
            }
            else {
            guard song.audioURL != viewModel.currentlyPlaying() else {
               pauseCurrentlyPlaying()
                return
            }
            pauseCurrentlyPlaying()
            playAudio(url: song.audioURL ?? "")
                viewLayout.setButtonUI(state: .pause, actionBtn: sender )
        }
        }
    }

}


extension SongsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ViewConstants.cellHeight
    }
}

extension SongsViewController : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : SongsTableViewCell = tableView.dequeueReusableCell(withIdentifier: ViewConstants.cell, for: indexPath) as! SongsTableViewCell
        guard let data = viewModel.getData(index: indexPath) else {
            return UITableViewCell()
        }
        
        isDownloaded = viewModel.fetchSongs(url: data.audioURL ?? "")
        if isDownloaded ?? false && viewModel.downloadedSongs.contains(data.audioURL ?? "") {
         
                viewModel.songState = .play
            self.viewLayout.setButtonUI(state: .play, actionBtn: cell.actionBtn)
        }
        else {
            self.viewLayout.setButtonUI(state: .download, actionBtn: cell.actionBtn)
        }
        cell.actionBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        cell.setData(song: data)
        return cell
    }
    
    
}


