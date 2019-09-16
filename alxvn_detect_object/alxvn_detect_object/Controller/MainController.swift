//
//  ViewController.swift
//  Allexceed_Timecard
//
//  Created by HieuTC on 7/25/19.
//  Copyright © 2019 HieuTC. All rights reserved.
//

import UIKit
import AVFoundation
import KRProgressHUD



class MainController: UIViewController, AVCapturePhotoCaptureDelegate, AVSpeechSynthesizerDelegate {
    
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    
    @IBOutlet weak var btnDetect: UIButton!
    
    private var captureSession = AVCaptureSession()
    private var backCamera: AVCaptureDevice?
    private var frontCamera: AVCaptureDevice?
    private var currentCamera: AVCaptureDevice?
    
    private var photoOutput = AVCapturePhotoOutput()
    private var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    private var isFirst = true
    private var isSettingClick = false
    private var isFunctionButtonClick = false
    
    private var taskDetect: URLSessionDataTask?
    
    private var countDetectFail = 0
    private var imgSrreenBackground: UIImageView?
    private var urlExecute:String = ""

    private var usernameTimecardInput:String = ""
    private var rightBarButton = UIBarButtonItem()
    
    //1. start
    //2. end
    //3. undo start
    //4. undo end
    private var function:Int = 0
    
    
    let synthesizer = AVSpeechSynthesizer()
    private var utterance: AVSpeechUtterance?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgSrreenBackground = Util.assignbackground(view: self.view)
        synthesizer.delegate = self
        
        
        self.view.addSubview(imgSrreenBackground!)
        self.view.sendSubviewToBack(imgSrreenBackground!)
        
        self.isFirst = true
        
        setUpNavBar()
        
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
//        swipeLeft.direction = .left
//        self.view.addGestureRecognizer(swipeLeft)
        
        
        
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            //showMenu()
            print("Swipe Right")
        }
        else if gesture.direction == .left {
            //    self.btnMenuClick(sender: rigtButtonBar, event: UIEvent.init().to(for: rigtButtonBar as! UIView))
//            self.showMenu()
            //print("Swipe Left")
        }
        else if gesture.direction == .up {
            print("Swipe Up")
        }
        else if gesture.direction == .down {
            print("Swipe Down")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraView.alpha = 0
        imgAvatar.alpha = 1
        
        executeWillAppear()
    }
    
    func executeWillAppear(){
        
        Util.setLabelTextColor(parentView: self.view)
        
        self.isSettingClick = false
        self.isFunctionButtonClick = false
        self.countDetectFail = 0
        
        imgSrreenBackground!.image = Util.initImageBackground(imageName: Constant.THEMES[Config.THEMES_NAME]!["bgScreen"]! as? String ?? "")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isFirst{
            isFirst = false
            configCamera()
        }
        
        
        startRunningCaptureSession()
        setupViewMode()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        stopRunningCaptureSession()
    }
    
    func setupViewMode(){
        
        cameraView.layer.cornerRadius = 20
        cameraView.layer.masksToBounds = true
        
        imgAvatar.layer.cornerRadius = 20
        imgAvatar.layer.masksToBounds = true
        
        if Config.CAMERA_DISPLAY_MODE{
            cameraView.alpha = 1
            imgAvatar.alpha = 0
        }
        else{
            cameraView.alpha = 0
            imgAvatar.alpha = 1
        }
    }
    
    func setUpNavBar(){
        //For title in navigation bar
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationItem.title = Constant.APP_NAME
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.blue,
             NSAttributedString.Key.font: UIFont(name: "Mplus1p-Bold", size: 22)!]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: Constant.SETTING, style: .done, target: self, action: #selector(self.btnSettingClick(sender:)))
        
//        rightBarButton = UIBarButtonItem.init(title: Constant.MENU, style: .done, target: self, action: #selector(self.btnMenuClick))
//        self.navigationItem.rightBarButtonItem = rightBarButton
        
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.blue,
             NSAttributedString.Key.font: UIFont(name: "Mplus1p-Bold", size: 22)!]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Mplus1p-Bold", size: 18)!], for: .normal)
    }
    
    @objc func btnSettingClick(sender: UIBarButtonItem) {
        self.taskDetect?.cancel()
        
        isSettingClick = true
        KRProgressHUD.dismiss()
        
        self.performSegue(withIdentifier: "SegueSetting", sender: self)
        
        
    }
    
    
    func configCamera(){
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
    }
    
    func setupCaptureSession(){
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        print("setup captureSession done")
    }
    
    func setupDevice(){
        
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes:[AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType:AVMediaType.video, position:AVCaptureDevice.Position.unspecified)
        
        let devices = deviceDiscoverySession.devices
        
        for device in devices{
            if device.position == AVCaptureDevice.Position.back{
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front{
                frontCamera = device
            }
        }
        
        currentCamera = backCamera
        
        print("setup device done")
    }
    
    func setupInputOutput(){
        do{
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format:[AVVideoCodecKey:AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput)
            
            print("setup input/output done")
            
        }catch{
            print(error)
        }
    }
    
    func setupPreviewLayer(){
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = CGRect(x: 0, y: 0, width: cameraView.frame.size.width, height: cameraView.frame.size.height)
        cameraView.layer.insertSublayer(cameraPreviewLayer!, at: 0)
        
        print("setup previewLayer done")
        
    }
    
    func startRunningCaptureSession(){
        if !captureSession.isRunning{
            captureSession.startRunning()
        }
        
        print("start session done")
    }
    
    func stopRunningCaptureSession(){
        if captureSession.isRunning{
            captureSession.stopRunning()
        }
        
        print("stop session done")
    }
    
    func executeGetFrameDetectImage(){
        Util.showAlert(message: "", type: 0)
        
        let photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.flashMode = .off
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300), execute: {
            self.photoOutput.capturePhoto(with: photoSettings, delegate: self)
        })
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation() else {
            KRProgressHUD.dismiss()
            print("no data")
            return
        }
        
        guard let image = UIImage(data: imageData) else {
            KRProgressHUD.dismiss()
            print("no data")
            return
        }
        
        let imageResize = Util.resizeImage(image: image, quality: 0.5)
        
        let base64str = Util.convertUIImageToBase64(image:imageResize)
        sendImage(base64Str: base64str)
    }
    
    func sendImage(base64Str:String){
        
        let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: OperationQueue.main)
        let url = URL(string: Config.SERVER_URL + Config.DETECT_OBJECT_API)!
        
        let parameterDictionary = [
            "image_data" : base64Str
            ] as [String : Any]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("false", forHTTPHeaderField: "cache")
//        request.timeoutInterval = TimeInterval(20)
        request.timeoutInterval = TimeInterval(Config.REQUEST_TIMEOUT)
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            KRProgressHUD.dismiss()
            return
        }
        request.httpBody = httpBody
        
        if self.isSettingClick{
            KRProgressHUD.dismiss()
            return
        }
        
        if !NetworkManager.isConnectedToNetwork() {
            
            Util.showAlert(message: Constant.NETWORK_UNAVAILABLE, type: Constant.ALERT_MODE_ERROR)
            
            self.isFunctionButtonClick = false
            KRProgressHUD.dismiss()
            return
        }
        
        //Util.showAlert(message: "", type: 0)
        
        self.taskDetect = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            if error != nil{
                
                self.isFunctionButtonClick = false
                
                if self.isSettingClick{
                    return
                }
                
                if error!.localizedDescription != "" {
                    Util.showAlert(message: Util.convertErrorText(errorMessage: error!.localizedDescription), type: Constant.ALERT_MODE_ERROR)
                }
                else{
                    Util.showAlert(message: Util.convertErrorText(errorMessage: Constant.SERVER_ERROR), type: Constant.ALERT_MODE_ERROR)
                }
                
                return
            }
            
            let data = data
            
            if data == nil {
                
                Util.showAlert(message: Constant.DATA_NONE, type: Constant.ALERT_MODE_ERROR)
                
                self.isFunctionButtonClick = true
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]
            
            if json == nil {
                
                Util.showAlert(message: Constant.DATA_NONE, type: Constant.ALERT_MODE_ERROR)
                
                self.isFunctionButtonClick = true
                return
                
            }
            
            let status = json!["status"] as? Bool ?? false
            let message = json!["message"] as? String ?? Constant.SERVER_ERROR
            
            if status{
                //KRProgressHUD.dismiss()
                
                //go to result screen
                if self.isSettingClick{
                    KRProgressHUD.dismiss()
                    return
                }
                self.playVoice(message: message)
                
                Util.showAlert(message: message, type: Constant.ALERT_MODE_INFO)
                
            }else{
                
                //if detect fail -> continue send image
                if self.isSettingClick{
                    return
                }
                
                self.isFunctionButtonClick = false
                Util.showAlert(message: message, type: Constant.ALERT_MODE_ERROR)
            }
        })
        self.taskDetect?.resume()
    }
    
    override func viewDidLayoutSubviews() {
        cameraPreviewLayer?.frame = CGRect(x: 0, y: 0, width: cameraView.frame.size.width, height: cameraView.frame.size.height)
    }
    
    @IBAction func unwindTonameMain(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.stopVoice()
//        if segue.identifier == "SegueConfirm"{
//            let destination = segue.destination as! ConfirmViewController
//            destination.delegate = self
//        }
//        else if segue.identifier == "SegueWebview"{
//            let destination = segue.destination as! WebViewController
//            destination.loadWebviewMode = self.loadwebViewMode
//        }
//        else if segue.identifier == "SegueNotificationPM"{
//            let destination = segue.destination as! NotificationPMViewController
//            destination.mailContentFromParent = lblResult.text!
//            self.lblResult.text = ""
//        }
//        else{
//
//        }
    }
    
    @IBAction func btnDetectClick(_ sender: Any) {
        executeGetFrameDetectImage()
    }
    
    func playVoice(message: String!){
        self.stopVoice()
        
        self.utterance = AVSpeechUtterance(string: message)
        self.utterance!.voice = AVSpeechSynthesisVoice(language: Config.VOICE_LAGUAGE)
        self.synthesizer.speak(self.utterance!)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
       
    }
    
    func stopVoice() {
        self.synthesizer.stopSpeaking(at: .immediate)
    }
    
}

