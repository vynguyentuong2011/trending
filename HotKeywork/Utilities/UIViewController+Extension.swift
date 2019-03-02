//
//  UIViewController+Extension.swift
//  HotKeywork
//
//  Created by Ms Vi Nguyen Tuong Vi on 3/2/19.
//  Copyright © 2019 Ms Vi Nguyen Tuong Vi. All rights reserved.
//

import Foundation
import UIKit
import AZDialogView

extension UIViewController {
    
    func dispatchToMainQueue(function: @escaping () -> ()) {
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                function()
            }
            return
        }
        function()
    }
    
    func showAlertWithAction(_ title: String, body: String, fun: (() -> Void)? = nil) {
        self.dispatchToMainQueue {
            let dialog = AZDialogViewController(title: title, message: body)
            dialog.buttonStyle = { (button,height,position) in
                button.layer.borderColor = UIColor(red: 48/255, green: 36/255, blue: 128/255, alpha: 1.0).cgColor
                button.setTitleColor(UIColor(red: 48/255, green: 36/255, blue: 128/255, alpha: 1.0), for: .normal)
            }
            
            dialog.addAction(AZDialogAction(title: "OK", handler: { (dialog) -> (Void) in
                dialog.dismiss()
            }))
            dialog.show(in: self)
        }
    }
}
