//
//  ResultViewController.swift
//  alxvn_detect_object
//
//  Created by HieuTC on 9/16/19.
//  Copyright © 2019 HieuTC. All rights reserved.
//

import UIKit
import AVFoundation

class ResultViewController: UIViewController, AVSpeechSynthesizerDelegate  {
    
    @IBOutlet weak var imgResult: UIImageView!

    
    public var imageResult = UIImage()
    public var mesageResult:String = ""

    let synthesizer = AVSpeechSynthesizer()
    private var utterance: AVSpeechUtterance?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBar()
        synthesizer.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imgResult.image = self.imageResult
        
    }
    
    override func viewDidAppear(_ animated: Bool) {

        playVoice(message: mesageResult)
    }
    
    func setUpNavBar(){
        //For title in navigation bar
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationItem.title = Constant.APP_NAME
        
        addBackButton()
    }
    
    func addBackButton(){
        
       self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: Constant.BACK, style: .plain, target: self, action: #selector(self.btnBackClick(sender:)))
    }
    
    @objc func btnBackClick(sender: UIBarButtonItem) {
        stopVoice()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func playVoice(message: String!){
        self.stopVoice()
        
        self.utterance = AVSpeechUtterance(string: message)
        self.utterance!.voice = AVSpeechSynthesisVoice(language: Config.VOICE_LANGUAGE)
        self.synthesizer.speak(self.utterance!)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        
    }
    
    func stopVoice() {
        self.synthesizer.stopSpeaking(at: .immediate)
    }
    
}
