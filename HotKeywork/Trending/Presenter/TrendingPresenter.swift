//
//  TrendingPresenter.swift
//  HotKeywork
//
//  Created by Ms Vi Nguyen Tuong Vi on 3/2/19.
//  Copyright © 2019 Ms Vi Nguyen Tuong Vi. All rights reserved.
//

import Foundation
import UIKit

class TrendingPresenter: TrendingPresenterProtocol {

    weak var view: TrendingViewProtocol?
    var interactor: TrendingInteractorProtocol?
    var router: TrendingRouterProtocol?
    
    func fetchHotKeyword() {
        self.interactor?.fetchHotKeyword()
    }
    
    func fetchBackgroundColors() {
        self.interactor?.fetchBackgroundColors()
    }
    
    func dismiss() {
        self.router?.dissmiss(view: view!)
    }
}

extension TrendingPresenter: TrendingInteractorCallbackProtocol {
    func didRetrivedBackgroundColors(_ result: [UIColor]) {
        self.view?.didRetrivedBackgroundColors(result)
    }
    
    func didRetrivedHotKeywords(_ result: [Keyword]) {
        self.view?.didRetrivedHotKeywords(result)
    }
}
