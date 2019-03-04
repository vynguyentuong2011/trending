//
//  WelcomePresenter.swift
//  HotKeywork
//
//  Created by Ms Vi Nguyen Tuong Vi on 3/2/19.
//  Copyright © 2019 Ms Vi Nguyen Tuong Vi. All rights reserved.
//

import Foundation

class WelcomePresenter: WelcomePresenterProtocol {
    
    weak var view: WelcomeViewProtocol?
    var interactor: WelcomeInteractorProtocol?
    var router: WelcomeRouterProtocol?
    
    func showTrendingScreen() {
        router?.presentTrendingScreen(view: view!)
    }
}

extension WelcomePresenter: WelcomeInteractorCallbackProtocol {
    
}
