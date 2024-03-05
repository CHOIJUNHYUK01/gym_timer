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
    private lazy var startTimerButton = initialView.playButton
    
    var minuteSelected = 1
    var secondSelected = 30
    
    var timeRangeManager = TimeRangeManager()
    
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
        minutePickerView.dataSource = self
        secondPickerView.delegate = self
        secondPickerView.dataSource = self
    }
    
    func setData() {
        timeRangeManager.setTimeRange()
    }
    
    func setPickerViewDefaultValue() {
        minutePickerView.selectRow(1, inComponent: 0, animated: true)
        secondPickerView.selectRow(30, inComponent: 0, animated: true)
    }
    
    func setTimerButtonAction() {
        self.startTimerButton.addTarget(self, action: #selector(startTimerTapped), for: .touchUpInside)
    }
    
    @objc func startTimerTapped() {
        let timerVC = TimerViewController()
        timerVC.totalSeconds = 60 * minuteSelected + secondSelected
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
        if pickerView == minutePickerView {
            return timeRangeManager.getMinutes().count
        }
        return timeRangeManager.getSeconds().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == minutePickerView {
            return String(timeRangeManager.getMinutes()[row])
        }
        return String(timeRangeManager.getSeconds()[row])
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == minutePickerView {
            self.minuteSelected = timeRangeManager.getMinutes()[row]
        } else {
            self.secondSelected = timeRangeManager.getSeconds()[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 64
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 80
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
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
    }
}
