//
//  Array+Extension.swift
//  HotKeywork
//
//  Created by Ms Vi Nguyen Tuong Vi on 3/2/19.
//  Copyright © 2019 Ms Vi Nguyen Tuong Vi. All rights reserved.
//

import Foundation

extension Array {
    func rearrange<T>(array: Array<T>, fromIndex: Int, toIndex: Int) -> Array<T>{
        var arr = array
        let element = arr.remove(at: fromIndex)
        arr.insert(element, at: toIndex)
        
        return arr
    }
}
