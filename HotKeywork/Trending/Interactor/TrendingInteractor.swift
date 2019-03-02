//
//  TrendingInteractor.swift
//  HotKeywork
//
//  Created by Ms Vi Nguyen Tuong Vi on 3/2/19.
//  Copyright © 2019 Ms Vi Nguyen Tuong Vi. All rights reserved.
//

import Foundation

class TrendingInteractor: TrendingInteractorProtocol {
    var presenter: TrendingInteractorCallbackProtocol?
    
    func fetchHotKeyword() {
        HotKeywordAPIClient.sharedInstance.loadAllHotKeywordFromServer().onSuccess { (keywords) in
            self.presenter?.didRetrivedHotKeywords(keywords)
        }
    }
    
    func fetchBackgroundColors() {
        var bgColors = BackgroundColor.getAllBackgroundColors()
        self.presenter?.didRetrivedBackgroundColors(bgColors)
    }
    
}
