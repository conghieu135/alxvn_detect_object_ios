//
//  Config.swift
//  Allexceed_Timecard
//
//  Created by allexceed on 7/26/19.
//  Copyright © 2019 HieuTC. All rights reserved.
//

import Foundation

class Config
{
    static var SERVER_URL = "http://192.168.10.144:8989"
    static var CAMERA_DISPLAY_MODE = true
    static var HAS_CONFIG_FILE = false
    
    static let MAX_IMAGE_USER = 5
    
    static let DETECT_OBJECT_API = "/detect_object_api/"

    
    static let REQUEST_TIMEOUT = 5 //second
    static let SEND_MAIL_TIMEOUT = 20 //second
    static let TIME_WAIT_SHOW_CAMERA = 200 //milisecond
    static let TRAINING_TIMEOUT = 20
    
    static var IMAGE_VIEW_BACKGROUND = "bgScreen.jpg"
    static var THEMES_NO = 1
    static var THEMES_NAME = "themes1"
    
    static var IS_ADMIN = 0
    static var USER_ID_ADMIN = ""
    
    static let TIME_SHOW_ALERT = 2.0
    
    static let VOICE_LAGUAGE = "en-US"
    
    static let MAX_CONFIRM_FAIL = 3
    
    static let MENU_ARR = ["   Danh sách User", "   Đăng ký User", "   Thông báo PM", "   Setting"]
    static let MENU_ICON_ARR = ["icUserList", "icAddUser", "icSendMail", "icSetting"]
    
    static let EMAIL_CONFIG = [
        "email": "devtestalx@gmail.com",
        "password": "developtest135"
    ]
}
