//
//  MemoCollectionViewCell.swift
//  VideoMemo
//
//  Created by Emi M on 2023/09/18.
//

import UIKit
import RealmSwift

class MemoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var memoLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var screenShotImageView: UIImageView!
    
    let realm = try! Realm()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func setCell(memo: String, image: UIImage, time: String) {
//        memoLabel.lineBreakMode = .byWordWrapping
        memoLabel.text = memo
        timeLabel.text = time
        screenShotImageView.image = image
    }
    
}
