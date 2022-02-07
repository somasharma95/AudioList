//
//  SongsViewLayout.swift
//  MusicList
//
//  Created by Apple on 22/01/22.
//

import UIKit

struct ViewConstants {
    static let cell = "SongsTableViewCell"
    static let cellHeight : CGFloat = 150
    static let downloadNib = "download"
    static let playNib = "play"
    static let pauseNib = "pause"
    static let title = "Songs"
    static let entity = "Song"
    static let keyName = "audio"
    static let urlKey = "url"
}

final class SongsViewLayout: UIView {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: ViewConstants.cell, bundle: nil), forCellReuseIdentifier: ViewConstants.cell)
        }
    }
    
    func getButtonIndexInTableView(tableView: UITableView, view: UIView) -> IndexPath? {
           let pos = view.convert(CGPoint.zero, to: tableView)
           return tableView.indexPathForRow(at: pos)
       }
    
    func setButtonUI(state : SongState, actionBtn:UIButtonEnhanced) {
        switch state {
        case .download:
            actionBtn.setImage(UIImage(named: ViewConstants.downloadNib), for: .normal)
        case .downloading:
            actionBtn.drawCircle()
            actionBtn.progress = 1
        case .pause:
            actionBtn.setImage(UIImage(named: ViewConstants.pauseNib), for: .normal)
        case .play:
            actionBtn.progress = 0
            actionBtn.setImage(UIImage(named: ViewConstants.playNib), for: .normal)
        }
    }

}

