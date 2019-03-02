//
//  HotKeywordCollectionViewCell.swift
//  HotKeywork
//
//  Created by Ms Vi Nguyen Tuong Vi on 3/2/19.
//  Copyright © 2019 Ms Vi Nguyen Tuong Vi. All rights reserved.
//

import UIKit

class HotKeywordCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var backgroundContent: UIView!
    @IBOutlet weak var keywordContent: UILabel!
    
    func fillData(item: Keyword, backgroundColor: UIColor) {
        self.iconImage.image = item.image
        self.keywordContent.text = item.content
        self.backgroundContent.backgroundColor = backgroundColor
    }
}
