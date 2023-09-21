//
//  MemoCollectionViewCell.swift
//  VideoMemo
//
//  Created by Emi M on 2023/09/18.
//

import UIKit

class MemoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var memoLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var screenShotImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(memo: String, imageURL: String) {
        memoLabel.text = memo
        
    }

}
