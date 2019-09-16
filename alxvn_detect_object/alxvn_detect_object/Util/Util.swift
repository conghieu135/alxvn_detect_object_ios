//
//  Util.swift
//  Allexceed_Timecard
//
//  Created by allexceed on 7/26/19.
//  Copyright © 2019 HieuTC. All rights reserved.
//

import Foundation
import UIKit
import KRProgressHUD

class Util{
    
    static func readConfig(){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent(Constant.CONFIG_FILE_PATH) {
            
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                do{
                    let content = try String(contentsOf: pathComponent, encoding: .utf8)
                    
                    let data: Data? = content.data(using: .utf8)
                    
                    guard let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] else {
                        //Collection(nil)
                        return
                    }
                    
                    Config.CAMERA_DISPLAY_MODE = json["CAMERA_DISPLAY_MODE"] as? Bool ?? false
                    Config.SERVER_URL = json["SERVER_URL"] as? String ?? Config.SERVER_URL
                    Config.THEMES_NO = json["THEMES_NO"] as? Int ?? Config.THEMES_NO
                    Config.THEMES_NAME = json["THEMES_NAME"] as? String ?? Config.THEMES_NAME

                    
                    Config.HAS_CONFIG_FILE = true
                    

                    return
                    
                }catch{
                    print(error)
                }
            }
        }
    }
    
    static func saveConfig(){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent(Constant.CONFIG_FILE_PATH) {
            var config = "{"
            config += "\"CAMERA_DISPLAY_MODE\": " + String(Config.CAMERA_DISPLAY_MODE)
            config += " , \"SERVER_URL\": \"" + Config.SERVER_URL + "\""
            config += " , \"THEMES_NO\": " + String(Config.THEMES_NO)
            config += " , \"THEMES_NAME\": \"" + ("themes" + String(Config.THEMES_NO)) + "\""
            
            config += "}"
            
            do {
                try config.write(to: pathComponent, atomically: false, encoding: .utf8)
                
            }
            catch {
                print(error)
            }
        }
    }
    
    static func makeLoading(title:String?, message: String?)->UIAlertController{
        let activityIndicatorAlert = UIAlertController(title: NSLocalizedString(title ?? "", comment: ""), message: NSLocalizedString(message ?? "", comment: ""), preferredStyle: UIAlertController.Style.alert)
        
        let height:NSLayoutConstraint = NSLayoutConstraint(item: activityIndicatorAlert.view!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 500)
        activityIndicatorAlert.view.addConstraint(height)
        
        
        
        activityIndicatorAlert.addActivityIndicator()
        
        return activityIndicatorAlert
    }
    
    static func makeAlertOK(title: String?, message: String?) -> UIAlertController{
        // Add "OK" Button to alert, pressing it will bring you to the settings app
        let alert = UIAlertController(title: title ?? "", message: message ?? "", preferredStyle: .alert)
        
        // Add "OK" Button to alert, pressing it will bring you to the settings app
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
        }))
        
        return alert
    }
    
    static func resizeImage(image: UIImage, quality: CGFloat) -> UIImage {
        let size = image.size
        
        let newSize = CGSize(width: size.width * quality, height: size.height * quality)
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    static func convertUIImageToBase64(image: UIImage) -> String{
        let compression = 1.0
        let imageOrientation = image.fixedOrientation()
        let imageData = imageOrientation.jpegData(compressionQuality: CGFloat(compression))
        
        return imageData!.base64EncodedString()
    }
    
    static func assignbackground(view:UIView, isAddSubView: Bool = true)->UIImageView{
        
        let background = UIImage(named: Constant.THEMES[Config.THEMES_NAME]!["bgScreen"]! as? String ?? "")
        
        let imgSrreenBackground = UIImageView(frame: view.bounds)
        imgSrreenBackground.contentMode =  UIView.ContentMode.scaleAspectFit
        imgSrreenBackground.clipsToBounds = true
        imgSrreenBackground.image = background
        imgSrreenBackground.center = view.center
        
        if isAddSubView{
            view.addSubview(imgSrreenBackground)
            view.sendSubviewToBack(imgSrreenBackground)
        }
        
        
        return imgSrreenBackground
    }
    
    static func initImageBackground(imageName: String) -> UIImage{
        let background = UIImage(named: imageName)
        
        return background!
    }
    
    static func showAlert(message:String, type:Int = 0, duration:Double = Config.TIME_SHOW_ALERT){
        KRProgressHUD
            .set(style: .custom(background: UIColor(white: 1, alpha: 1), text: .orange, icon: nil))
            .set(maskType: .clear)
            .set(font: UIFont.systemFont(ofSize: 24))
            .set(activityIndicatorViewColors: [.blue, .orange])
            .set(duration: duration)
        
        switch type {
        case Constant.ALERT_MODE_SHOW:
            KRProgressHUD.show()
            break
        case Constant.ALERT_MODE_INFO:
            KRProgressHUD.showInfo(withMessage: message)
            break
        case Constant.ALERT_MODE_SUCCESS:
            KRProgressHUD.showSuccess(withMessage: message)
            break
        case Constant.ALERT_MODE_WARNING:
            KRProgressHUD.showWarning(withMessage: message)
            break
        case Constant.ALERT_MODE_ERROR:
            KRProgressHUD.showError(withMessage: message)
            break
        case Constant.ALERT_MODE_SHOW_TEXT:
            KRProgressHUD.show(withMessage: message, completion: nil)
            break
        default:
            break
        }
        
    }
    
    static func setLabelTextColor(parentView: UIView, themesNo: Int = Config.THEMES_NO){
        let themesName = "themes" + String(themesNo)
        
        for view in parentView.subviews as [Any] {
            if let label = view as? UILabel {

                if label.tag != -1{
                    let textColor = Constant.THEMES[themesName]!["labelTextColor"]! as! UIColor
                    label.textColor = textColor
                }
                else{
                    let textColor = Constant.THEMES[themesName]!["textResultColor"]! as! UIColor
                    label.textColor = textColor
                }

            }
        
            if view is UIButton{
                continue
            }

            if let constainer  = view as? UIView{
                setLabelTextColor(parentView: constainer, themesNo: themesNo)
            }
        }
    }
    
    static func checkPartentText(url: String, parten: String) -> Bool {
        
        let urlRegEx = parten
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
        let result = urlTest.evaluate(with: url)
        return result
    }
    
    static func convertErrorText(errorMessage: String)-> String {
        switch errorMessage {
        case "The resource could not be loaded because the App Transport Security policy requires the use of a secure connection.":
            return "Cannot connect to the server"
        default:
            return errorMessage
        }
        
    }
    
    static func setCorderButton(btn:UIButton){
        btn.layer.cornerRadius = 5
    }

    
    static func checkPartenMatches(for pattern: String, inString string: String) -> BooleanLiteralType {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return false
        }
        
        let range = NSRange(string.startIndex..., in: string)
        let matches = regex.matches(in: string, options: [], range: range)
        
        let arr: [String] =  matches.map {
            let range = Range($0.range, in: string)!
            return String(string[range])
        }
        
        return arr.count > 0 ? true : false
    }
    
    static func getTextFromParten(for pattern: String, inString string: String) -> [String]{
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return []
        }
        
        let range = NSRange(string.startIndex..., in: string)
        let matches = regex.matches(in: string, options: [], range: range)
        
        let arr: [String] =  matches.map {
            let range = Range($0.range, in: string)!
            return String(string[range])
        }
        
        return arr
    }
    
    
}
