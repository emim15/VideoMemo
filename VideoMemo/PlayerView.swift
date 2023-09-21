//
//  PlayerView.swift
//  VideoMemo
//
//  Created by Emi M on 2023/09/20.
//

import UIKit
import AVFoundation

class PlayerView: UIView {
    // Override the property to make AVPlayerLayer the view's backing layer.
        override static var layerClass: AnyClass { AVPlayerLayer.self }
        
        // The associated player object.
        var player: AVPlayer? {
            get { playerLayer.player }
            set { playerLayer.player = newValue }
        }
        
        private var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
}
