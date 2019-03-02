//
//  WelcomeRouter.swift
//  HotKeywork
//
//  Created by Ms Vi Nguyen Tuong Vi on 3/2/19.
//  Copyright © 2019 Ms Vi Nguyen Tuong Vi. All rights reserved.
//

import Foundation
import UIKit

class WelcomeRouter: WelcomeRouterProtocol {
    
    static var welcomeStoryboard: UIStoryboard {
        return UIStoryboard(name:"Welcome",bundle: Bundle.main)
    }
    
    static let welcomeIdentifier = "WelcomeViewController"
    
    static func createModule() -> WelcomeViewController {
        let view = welcomeStoryboard.instantiateViewController(withIdentifier: welcomeIdentifier) as! WelcomeViewController
        let presenter: WelcomePresenterProtocol & WelcomeInteractorCallbackProtocol = WelcomePresenter()
        let interactor: WelcomeInteractorProtocol = WelcomeInteractor()
        let router: WelcomeRouterProtocol = WelcomeRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func presentTrendingScreen(view: WelcomeViewProtocol) {
        let trendingViewController = TrendingRouter.createModule()
        if let sourceView = view as? UIViewController {
            sourceView.present(trendingViewController, animated: true, completion: nil)
        }
    }
}
