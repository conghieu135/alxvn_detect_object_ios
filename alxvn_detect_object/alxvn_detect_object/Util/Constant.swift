//
//  Constant.swift
//  Allexceed_Timecard
//
//  Created by allexceed on 7/26/19.
//  Copyright © 2019 HieuTC. All rights reserved.
//

import Foundation
import UIKit

class Constant{
    
    static let CONFIG_FILE_PATH = "config.txt"
    static let APP_NAME = "Detect Object"
    static let SETTING = "Setting"
    static let SAVE = "Save"
    static let BACK = "Back"
    
    static let LOOK_STRAIGHT = "Look straight"
    static let LOOK_UP = "Look up"
    static let LOOK_RIGHT = "Look right"
    static let LOOK_DOWN = "Look down"
    static let LOOK_LEFT = "Look left"
    
    static let PLEASE_WAIT = "Please wait..."
    static let PROCESS_TRAINING = "Registering user..."
    static let SERVER_URL_INVALID = "Server URL is invalid."
    static let PLEASE_INPUT_SERVERURL = "Please enter server url!"
    static let NO_PERMISSION = "You do not have access to this function."
    
    static let INTERNAL_SYSTEM_SERVER_URL_INVALID = "Internal system server URL is invalid."
    static let PLEASE_INPUT_INTERNAL_SYSTEM_SERVERURL = "Please enter internal system server url!"
    
    
    static let SERVER_ERROR = "Server error."
    
    static let WARNING_STR = "Warning"
    static let INFO_STR = "Info"
    static let ERROR_STR = "Error"
    
    static let DATA_NONE = "Data is none."
    static let NETWORK_UNAVAILABLE = "Network is unavailable."
    
    static let DETECT_FACE_FAIL = "Face detection failed."
    static let REGIST_FAIL = "Registration failed."
    
    static let ALERT_MODE_SHOW = 0
    static let ALERT_MODE_INFO = 1
    static let ALERT_MODE_SUCCESS = 2
    static let ALERT_MODE_WARNING = 3
    static let ALERT_MODE_ERROR = 4
    static let ALERT_MODE_SHOW_TEXT = 5
    
    static let CAMERA_NOT_PERMISSION = "No camera access."
    static let CAMERA_BROKEN = "Camera is broken."

    
    static let SERVER_URL_PARTEN = "\\b((http|https)://)([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})\\:([0-9]{1,4})\\b"
    
    
    static let THEMES = [
        "themes1": [
            "bgScreen": "bgScreen.jpg",
            "textResultColor": UIColor.tangerine,
            "labelTextColor": UIColor.blue
        ],
        
        "themes2": [
            "bgScreen": "bgScreen2.jpg",
            "textResultColor": UIColor.snow,
            "labelTextColor": UIColor.snow
        ],
        
        "themes3": [
            "bgScreen": "bgScreen3.jpg",
            "textResultColor": UIColor.tangerine,
            "labelTextColor": UIColor.blue
        ],
        
        "themes4": [
            "bgScreen": "bgScreen4.jpg",
            "textResultColor": UIColor.blue,
            "labelTextColor": UIColor.blue
        ]
        
    ]
}
