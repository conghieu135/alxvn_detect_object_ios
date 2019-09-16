//
//  SettingViewController.swift
//  Allexceed2019_ten_years
//
//  Created by allexceed on 7/10/19.
//  Copyright © 2019 Allexceed. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController{
    
    //outlet
    @IBOutlet weak var swiDisplayCamera: UISwitch!
    @IBOutlet weak var txtURL: UITextField!
    
    @IBOutlet weak var viewThemes: UIView!
    
    
    var isSave: Bool = false

    private var imgSrreenBackground: UIImageView?   
    private var themesNo: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imgSrreenBackground = Util.assignbackground(view: self.view)
        view.addSubview(imgSrreenBackground!)
        view.sendSubviewToBack(imgSrreenBackground!)
        self.setUpNavBar()
        
        
        //set event for button themes
        for view in viewThemes.subviews as [UIView] {
            if let btn = view as? UIButton {
                btn.addTarget(self, action: #selector(btnThemes_click), for: .touchUpInside)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        swiDisplayCamera.isOn = Config.CAMERA_DISPLAY_MODE
        txtURL.text = Config.SERVER_URL
    
        txtURL.layer.borderWidth = 0.5
        txtURL.layer.cornerRadius = 3
        
        
        self.themesNo = Config.THEMES_NO
        setLabelColorText(themesNo: Config.THEMES_NO)
        setSelectedThemes(themesNo: Config.THEMES_NO)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        isSave = true
    }

    func setUpNavBar(){
        //For title in navigation bar
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationItem.title = Constant.SETTING

        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: Constant.SAVE, style: .plain, target: self, action: #selector(self.btnBackClick(sender:)))
     
    }
    
    @objc func btnBackClick(sender: UIBarButtonItem) {
        
        if(txtURL.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            Util.showAlert(message: Constant.PLEASE_INPUT_SERVERURL, type: Constant.ALERT_MODE_WARNING, duration: 2)
            return
        }
        
        if !Util.checkPartentText(url: txtURL.text!, parten: Constant.SERVER_URL_PARTEN){
            Util.showAlert(message: Constant.SERVER_URL_INVALID, type: Constant.ALERT_MODE_ERROR, duration: 2)
            return
        }

        
        Config.SERVER_URL = txtURL.text ?? ""
        Config.CAMERA_DISPLAY_MODE = swiDisplayCamera.isOn
        Config.THEMES_NO = self.themesNo
        Config.THEMES_NAME = "themes" + String(self.themesNo)
        
        Util.saveConfig()
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    @IBAction func btnThemes_click(_ sender: Any) {
        changeTheme(themesNo: (sender as! UIButton).tag)
    }
 
    func changeTheme(themesNo:Int){
        self.themesNo = themesNo
        let themesName = "themes" + String(themesNo)
        
        imgSrreenBackground?.image = Util.initImageBackground(imageName: Constant.THEMES[themesName]!["bgScreen"]! as? String ?? "")
        
        setLabelColorText(themesNo: themesNo)
        setSelectedThemes(themesNo: themesNo)
    }
    
    func setSelectedThemes(themesNo:Int){
        for view in viewThemes.subviews as [UIView] {
            if let btn = view as? UIButton {
                
                if btn.tag == themesNo{
                    btn.layer.borderWidth = 1
                }
                else{
                    btn.layer.borderWidth = 0
                }
            }
        }
        
    }
    
    func setLabelColorText(themesNo: Int){

        Util.setLabelTextColor(parentView: self.view, themesNo: themesNo)
        
    }
}
