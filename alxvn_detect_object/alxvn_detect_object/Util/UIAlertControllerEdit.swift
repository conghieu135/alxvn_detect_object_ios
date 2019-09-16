//
//  UIAlertControllEdit.swift
//  Allexceed_Timecard
//
//  Created by allexceed on 7/26/19.
//  Copyright © 2019 HieuTC. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    private struct ActivityIndicatorData {
        static var activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    }
    
    func addActivityIndicator() {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 40,height: 40)
        
        ActivityIndicatorData.activityIndicator.style = .whiteLarge
        ActivityIndicatorData.activityIndicator.color =  UIColor(red: 90/255, green: 158/255, blue:242/255, alpha: 1)
        
        ActivityIndicatorData.activityIndicator.startAnimating()
        vc.view.addSubview(ActivityIndicatorData.activityIndicator)
        self.setValue(vc, forKey: "contentViewController")
    }
    
    func dismissActivityIndicator() {
        ActivityIndicatorData.activityIndicator.stopAnimating()
        self.dismiss(animated: false)
    }
}
