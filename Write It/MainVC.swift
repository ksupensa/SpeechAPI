//
//  MainVC.swift
//  Write It
//
//  Created by Spencer Forrest on 20/01/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit
import AVFoundation
import Speech

class MainVC: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var playBtn: UIButton!
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingSpinner.isHidden = true
    }
    
    private func speechRequest(){
        SFSpeechRecognizer.requestAuthorization{
            status in
            if status == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let url = Bundle.main.url(forResource: "test", withExtension: "m4a") {
                    do {
                        self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                        self.audioPlayer.delegate = self
                        self.audioPlayer.play()
                    } catch let err as NSError {
                        print(err.description)
                    }
                    
                    let speechRecognizer = SFSpeechRecognizer()
                    let speechRequest = SFSpeechURLRecognitionRequest(url: url)
                    
                    speechRecognizer?.recognitionTask(with: speechRequest) {
                        result, error in
                        if let err = error {
                            print(err)
                        } else {
                            if let text = result?.bestTranscription.formattedString {
                                self.textView.text = text
                            }
                        }
                    }
                }
            } else {
                print("Authorization Denied by User")
            }
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        loadingSpinner.stopAnimating()
        loadingSpinner.isHidden = true
        //playBtn.isHidden = false
    }
    
    @IBAction func playBtnPressed(_ sender: Any) {
        textView.text = ""
        //playBtn.isHidden = true
        loadingSpinner.startAnimating()
        loadingSpinner.isHidden = false
        speechRequest()
    }
}

