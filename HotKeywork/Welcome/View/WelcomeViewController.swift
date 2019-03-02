//
//  WelcomeViewController.swift
//  HotKeywork
//
//  Created by Ms Vi Nguyen Tuong Vi on 3/2/19.
//  Copyright © 2019 Ms Vi Nguyen Tuong Vi. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    var presenter: WelcomePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signInBtnTouchDown(_ sender: Any) {
        self.showAlertWithAction("Sign in", body: "We'll reserve later") {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func exploreBtnTouchDown(_ sender: Any) {
        presenter?.showTrendingScreen()
    }
    
}

extension WelcomeViewController: WelcomeViewProtocol {
    
}
