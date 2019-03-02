//
//  Keyword.swift
//  HotKeywork
//
//  Created by Ms Vi Nguyen Tuong Vi on 3/2/19.
//  Copyright © 2019 Ms Vi Nguyen Tuong Vi. All rights reserved.
//

import Foundation
import UIKit

struct Keyword {
    var content: String
    var image: UIImage
    
    init(content: String, image: UIImage) {
        self.content = content
        self.image = image
    }
    
    func keyValueDescription() -> [String: Any] {
        return [
            "content": self.content,
            "image": self.image.description,
        ]
    }
}
