//
//  InitAppViewController.swift
//  Allexceed2019_ten_years
//
//  Created by allexceed on 7/10/19.
//  Copyright © 2019 Allexceed. All rights reserved.
//

import UIKit
import KRProgressHUD
import AVFoundation

class InitAppViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        if UIImagePickerController.isSourceTypeAvailable(.camera){
            // Create Alert
            let alert = UIAlertController(title: "Camera", message: Constant.CAMERA_BROKEN, preferredStyle: .alert)
            
            // Add "OK" Button to alert, pressing it will bring you to the settings app
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                exit(0)
            }))
            // Show the alert with animation
            self.present(alert, animated: true)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {       
        if AVCaptureDevice.authorizationStatus(for: .video) !=  .authorized {

            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    //access allowed
                    self.havePermission()
                   
                } else {
                    
                    // Create Alert
                    let alert = UIAlertController(title: "Camera", message: Constant.CAMERA_NOT_PERMISSION, preferredStyle: .alert)

                    // Add "OK" Button to alert, pressing it will bring you to the settings app
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }))
                    // Show the alert with animation
                    self.present(alert, animated: true)
                    
                }
            })
        }
        else{
            self.havePermission()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Util.showAlert(message: "")
        Util.readConfig()
        _ = Util.assignbackground(view: self.view)
        Util.setLabelTextColor(parentView: self.view)
    }
    
    func havePermission(){

        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let loginViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainID") as? UINavigationController else {
            return
        }
        
        KRProgressHUD.dismiss()
        
        self.present(loginViewController, animated: true, completion: nil)
        
    }
}

