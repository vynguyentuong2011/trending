//
//  TrendingProtocol.swift
//  HotKeywork
//
//  Created by Ms Vi Nguyen Tuong Vi on 3/2/19.
//  Copyright © 2019 Ms Vi Nguyen Tuong Vi. All rights reserved.
//

import Foundation
import UIKit

protocol TrendingPresenterProtocol: class {
    var view: TrendingViewProtocol? {get set}
    var interactor: TrendingInteractorProtocol? {get set}
    var router: TrendingRouterProtocol? {get set}
    
    func fetchHotKeyword()
    func fetchBackgroundColors()
    func dismiss()
}

protocol TrendingViewProtocol: class {
    var presenter: TrendingPresenterProtocol? {get set}
    func didRetrivedHotKeywords(_ result: [Keyword])
    func didRetrivedBackgroundColors(_ result: [UIColor])
}

protocol TrendingInteractorProtocol: class {
    var presenter: TrendingInteractorCallbackProtocol? {get set}
    func fetchHotKeyword()
    func fetchBackgroundColors()
}

protocol TrendingInteractorCallbackProtocol: class  {
    func didRetrivedHotKeywords(_ result: [Keyword])
    func didRetrivedBackgroundColors(_ result: [UIColor])
}

protocol TrendingRouterProtocol: class {
    func dissmiss(view: TrendingViewProtocol)
}
