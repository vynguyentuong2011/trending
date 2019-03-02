//
//  TrendingRouter.swift
//  HotKeywork
//
//  Created by Ms Vi Nguyen Tuong Vi on 3/2/19.
//  Copyright © 2019 Ms Vi Nguyen Tuong Vi. All rights reserved.
//

import Foundation
import UIKit

class TrendingRouter: TrendingRouterProtocol {
    
    static var trendingStoryboard: UIStoryboard {
        return UIStoryboard(name:"Trending",bundle: Bundle.main)
    }
    
    static let trendingIdentifier = "TrendingViewController"
    
    static func createModule() -> TrendingViewController {
        let view = trendingStoryboard.instantiateViewController(withIdentifier: trendingIdentifier) as! TrendingViewController
        let presenter: TrendingPresenterProtocol & TrendingInteractorCallbackProtocol = TrendingPresenter()
        let interactor: TrendingInteractorProtocol = TrendingInteractor()
        let router: TrendingRouterProtocol = TrendingRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func dissmiss(view: TrendingViewProtocol) {
        if let sourceView = view as? UIViewController {
            sourceView.dismiss(animated: true, completion: nil)
        }
    }
}
