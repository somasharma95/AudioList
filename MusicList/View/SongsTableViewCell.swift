//
//  SongsTableViewCell.swift
//  MusicList
//
//  Created by Apple on 22/01/22.
//

import UIKit

final class SongsTableViewCell: UITableViewCell {

    @IBOutlet weak var actionBtn: UIButtonEnhanced!
   
    @IBOutlet weak var songName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
    
    func setData(song:SongInfo) {
        songName.text = song.name
    }
    
}
