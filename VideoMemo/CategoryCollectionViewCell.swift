//
//  CategoryCollectionViewCell.swift
//  VideoMemo
//
//  Created by Emi M on 2023/09/29.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var countButton: UIButton!
    @IBOutlet var colorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//  func setCell(title: String, count: Int, color: UIColor)
    func setCell(title: String, count: Int, color: String) {
        titleLabel.text = title
        countButton.setTitle(String(count), for: .normal)
        colorLabel.textColor = UIColor(hex: color)
    }

}
