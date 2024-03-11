//
//  TimerViewController.swift
//  EclipseTimer
//
//  Created by CHOIJUNHYUK on 3/5/24.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController {
    
    // view
    private let workingView = WorkingView()
    private let restView = RestView()
    
    // audio session
    private var ourAudioIsPlaying = false
    private let audioSession = AVAudioSession.sharedInstance()
    private let queue = DispatchQueue(label: "backgroundAudio", qos: .userInitiated, target: nil)
    
    // timer params
    private var timer: Timer?
    var totalSeconds: Int? {
        didSet {
            guard let _ = totalSeconds else { return }
            restView.restTime = 0
        }
    }
    private var elaspedTime = 0
    
    // control params
    var restMethod: Int?
    private lazy var volume = self.audioSession.outputVolume {
        willSet {
            if restMethod == 1 && view == workingView {
                changeToRestView()
            }
        }
    }
    private lazy var isBGMplaying = self.audioSession.isOtherAudioPlaying {
        didSet {
            if restMethod == 2 && oldValue && !isBGMplaying && view == workingView {
                changeToRestView()
            }
        }
    }
    
    private lazy var bgmIsPlaying = self.audioSession.isOtherAudioPlaying {
        willSet {
            if !newValue && view == workingView {
                changeToRestView()
            }
        }
    }
    
    override func loadView() {
        view = workingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setAudio()
        checkBGMplaying()
    }
    
    private func setAudio() {
        queue.async {
            try? self.audioSession.setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try? self.audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        }
        
        audioSession.addObserver(self, forKeyPath: "outputVolume", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    private func checkBGMplaying() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(isPlaying), userInfo: nil, repeats: true)
    }
    
    @objc func isPlaying() {
        isBGMplaying = audioSession.isOtherAudioPlaying
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "outputVolume" {
            volume = audioSession.outputVolume
        }
    }
    
    private func changeToRestView() {
        AudioServicesPlaySystemSound(SystemSoundID(1300))
        view = restView
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countUp), userInfo: nil, repeats: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if restMethod == 0 {
            changeToRestView()
        }
    }
    
    @objc func countUp() {
        guard let t = totalSeconds else { return }
        
        if elaspedTime == t {
            AudioServicesPlaySystemSound(SystemSoundID(1016))
            checkBGMplaying()
            elaspedTime = 0
            restView.restTime = elaspedTime
            view = workingView
            queue.async {
                sleep(1)
                self.focusOtherAppAudio()
            }
            return
        }
        
        if elaspedTime == t - 4 { focusAudioOurApp() }
        
        if elaspedTime >= t - 3 {
            AudioServicesPlaySystemSound(SystemSoundID(1302))
        }
        
        elaspedTime += 1
        restView.restTime = elaspedTime
    }

    
    func focusAudioOurApp() {
        guard audioSession.isOtherAudioPlaying == true && ourAudioIsPlaying == false else { return }
        ourAudioIsPlaying = true
        queue.async {
            try? self.audioSession.setCategory(.playback, mode: .default, options: [.duckOthers])
        }
    }
    
    func focusOtherAppAudio() {
        guard ourAudioIsPlaying == true else { return }
        ourAudioIsPlaying = false
        queue.async {
            try? self.audioSession.setCategory(.playback, mode: .default, options: [.mixWithOthers])
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        queue.async {
            try? self.audioSession.setActive(false)
        }
        audioSession.removeObserver(self, forKeyPath: "outputVolume", context: nil)
        ourAudioIsPlaying = false
        timer?.invalidate()
        elaspedTime = 0
    }
}
