//
//  TimerViewController.swift
//  EclipseTimer
//
//  Created by CHOIJUNHYUK on 3/5/24.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController {
    
    private let workingView = WorkingView()
    private let restView = RestView()
    
    var timer: Timer?
    
    var totalSeconds: Int? {
        didSet {
            guard let _ = totalSeconds else { return }
            restView.restTime = 0
        }
    }
    
    var elaspedTime = 0
    
    override func loadView() {
        view = workingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view = restView
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countUp), userInfo: nil, repeats: true)
    }
    
    @objc func countUp() {
        guard let t = totalSeconds else { return }
        
        if elaspedTime == t {
            AudioServicesPlaySystemSound(SystemSoundID(1016))
            timer?.invalidate()
            elaspedTime = 0
            restView.restTime = elaspedTime
            view = workingView
            return
        }
        
        if elaspedTime >= t - 3 {
            AudioServicesPlaySystemSound(SystemSoundID(1302))
        }
        
        elaspedTime += 1
        restView.restTime = elaspedTime
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
        elaspedTime = 0
    }
}
