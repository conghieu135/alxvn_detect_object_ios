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
    static var SERVER_URL = "http://192.168.10.144:8080"
    static var CAMERA_DISPLAY_MODE = true
    static var HAS_CONFIG_FILE = false
    
    static let MAX_IMAGE_USER = 5
    
    static let DETECT_AGE_GENDER_API = "/detect_age_gender/"
    static let ADD_USER_IMAGE_API = "/add_user_image/"
    static let TIMECARD_INPUT_API = "/start_end_working_time/"
    static let FACE_RECOGNITION_API = "/face_recognition_confirm/"
    static let UNDO_TIMECARD_INPUT_API = "/undo_timecard_input/"
    static let GET_DATA_PM_STAFF_API = "/get_list_pm_staff_for_combobox/"
    static let PM_UPDATE_TIMECARD_API = "/pm_update_timecard/"
    static let SEND_MAIL_API = "/sendMail/"
    static let UPDATE_CONFIG_API = "/update_config/"
    
    static let TIMECARD_LIST_API = "/user_timecard_list"
    static let USER_LIST_API = "/users"
    
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
