//
//  ViewController.swift
//  EclipseTimer
//
//  Created by CHOIJUNHYUK on 3/4/24.
//

import UIKit

final class ViewController: UIViewController {
    
    private let initialView = InitialView()
    private lazy var minutePickerView = initialView.minutePickerView
    private lazy var secondPickerView = initialView.secondPickerView
    private lazy var restPickerView = initialView.restPickerView
    private lazy var startTimerButton = initialView.playButton
    
    var minuteSelected = 1
    var secondSelected = 30
    var restMethodSelected = 1
    
    var timeRangeManager = TimeRangeManager()
    var restMethodManager = RestMethodManager()
    
    override func loadView() {
        view = initialView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        self.setPickerViewOptions()
        self.setData()
        self.setPickerViewDefaultValue()
        self.setTimerButtonAction()
        
    }
    
    func setPickerViewOptions() {
        minutePickerView.delegate = self
        secondPickerView.delegate = self
        restPickerView.delegate = self
        
        minutePickerView.dataSource = self
        secondPickerView.dataSource = self
        restPickerView.dataSource = self
    }
    
    func setData() {
        timeRangeManager.setTimeRange()
    }
    
    func setPickerViewDefaultValue() {
        minutePickerView.selectRow(1, inComponent: 0, animated: true)
        secondPickerView.selectRow(30, inComponent: 0, animated: true)
        restPickerView.selectRow(1, inComponent: 0, animated: true)
    }
    
    func setTimerButtonAction() {
        self.startTimerButton.addTarget(self, action: #selector(startTimerTapped), for: .touchUpInside)
    }
    
    @objc func startTimerTapped() {
        setAnalytics("start_timer")
        let timerVC = TimerViewController()
        timerVC.totalSeconds = 60 * minuteSelected + secondSelected
        timerVC.restMethod = restMethodSelected
        show(timerVC, sender: nil)
    }
}

extension ViewController: UIPickerViewDataSource {
    // 설정할 총 컴포넌트 개수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 각 컴포넌트 별 옵션 개수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case minutePickerView:
            return timeRangeManager.getMinutes().count
        case secondPickerView:
            return timeRangeManager.getSeconds().count
        case restPickerView:
            return restMethodManager.getRestMethods().count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case minutePickerView:
            return String(timeRangeManager.getMinutes()[row])
        case secondPickerView:
            return String(timeRangeManager.getSeconds()[row])
        case restPickerView:
            return restMethodManager.getRestMethods()[row]
        default:
            return ""
        }
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case minutePickerView:
            self.minuteSelected = timeRangeManager.getMinutes()[row]
        case secondPickerView:
            self.secondSelected = timeRangeManager.getSeconds()[row]
        case restPickerView:
            self.restMethodSelected = row
        default:
            break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch pickerView {
        case minutePickerView, secondPickerView:
            return 80
        case restPickerView:
            return 240
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        switch pickerView {
        case minutePickerView, secondPickerView:
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 44, weight: .bold)
            label.textColor = .yellow
            label.textAlignment = .center
            
            if pickerView == minutePickerView {
                label.text = String(timeRangeManager.getMinutes()[row])
                return label
            }
            label.text = String(timeRangeManager.getSeconds()[row])
            return label
        case restPickerView:
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: NSLocale.preferredLanguages[0] == "ko-KR" ? 36 : 32, weight: .bold)
            label.textColor = .yellow
            label.textAlignment = .right
            label.text = restMethodManager.getRestMethods()[row]
            return label
        default:
            let label = UILabel()
            label.text = String(localized: "Error")
            label.textAlignment = .center
            label.textColor = .yellow
            return label
        }
    }
}
