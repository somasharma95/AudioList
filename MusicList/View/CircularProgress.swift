//
//  CircularProgress.swift
//  MusicList
//
//  Created by Apple on 26/01/22.
//

import UIKit

enum DownloadStatus {
    case remote
    case downloading
    case paused
    case resumed
    case success
}


public class UIButtonEnhanced: UIButton {
    var progress: Float = 0 {
        didSet {
            circleShape.strokeEnd = CGFloat(self.progress)
        }
    }

    var circleShape = CAShapeLayer()
    
    public func drawCircle() {
        let x: CGFloat = 0.0
        let y: CGFloat = 0.0
        let circlePath = UIBezierPath(roundedRect: CGRect(x: x, y: y, width: self.frame.height, height: self.frame.height), cornerRadius: self.frame.height / 2).cgPath
        circleShape.path = circlePath
        circleShape.lineWidth = 3
        circleShape.strokeColor = UIColor.white.cgColor
        circleShape.strokeStart = 0
        circleShape.strokeEnd = 0
        circleShape.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(circleShape)
    }


    }
