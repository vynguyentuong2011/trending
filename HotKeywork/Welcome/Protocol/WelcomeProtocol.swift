//
//  WelcomeProtocol.swift
//  HotKeywork
//
//  Created by Ms Vi Nguyen Tuong Vi on 3/2/19.
//  Copyright © 2019 Ms Vi Nguyen Tuong Vi. All rights reserved.
//

import Foundation
import UIKit

protocol WelcomePresenterProtocol: class {
    var view: WelcomeViewProtocol? {get set}
    var interactor: WelcomeInteractorProtocol? {get set}
    var router: WelcomeRouterProtocol? {get set}
    
    func showTrendingScreen()
    
}

protocol WelcomeViewProtocol: class {
    var presenter: WelcomePresenterProtocol? {get set}
}

protocol WelcomeInteractorProtocol: class{
    var presenter: WelcomeInteractorCallbackProtocol? {get set}
    
}

protocol WelcomeInteractorCallbackProtocol: class  {
    
}

protocol WelcomeRouterProtocol: class {
    func presentTrendingScreen(view: WelcomeViewProtocol)
}
