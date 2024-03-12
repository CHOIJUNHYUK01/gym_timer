//
//  InitialView.swift
//  EclipseTimer
//
//  Created by CHOIJUNHYUK on 3/4/24.
//

import UIKit

class InitialView: UIView {
    
    private let playButtonSize: CGFloat = 88
    
    // MARK: 시간 선택 스택뷰
    private lazy var timeSelectStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [timePickerStackView, restPickerStackView])
        st.axis = .vertical
        st.alignment = .center
        st.spacing = 0
        return st
    }()
    
    // MARK: 피커뷰 스택뷰
    private lazy var timePickerStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [minutePickerView, pickerDividerLabel, secondPickerView])
        st.axis = .horizontal
        st.spacing = 0
        st.distribution = .fill
        return st
    }()
    
    // MARK: 분 선택 피커뷰
    lazy var minutePickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.backgroundColor = .black
        return pv
    }()
    
    private let pickerDividerLabel: UILabel = {
        let label = UILabel()
        label.text = ":"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // MARK: 초 선택 피커뷰
    lazy var secondPickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.backgroundColor = .black
        return pv
    }()
    
    // MARK: 휴식 방법 스택뷰
    private lazy var restPickerStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [restPickerView, restPickerLabel])
        st.axis = .horizontal
        st.spacing = 4
        st.distribution = .equalSpacing
        return st
    }()
    
    // MARK: 휴식 방법 피커뷰
    lazy var restPickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.backgroundColor = .black
        return pv
    }()
    
    private let restPickerLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "Setting Label")
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // MARK: 버튼 스택뷰
    private lazy var buttonStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [playButton])
        st.axis = .horizontal
        st.spacing = 0
        st.distribution = .equalSpacing
        return st
    }()
    
    // MARK: 시작 버튼
    lazy var playButton: UIButton = {
        let button = UIButton(type: .custom)
        if let image = UIImage(systemName: "play.circle") {
            button.setImage(image, for: .normal)
        }
        button.tintColor = UIColor(hexCode: "#008bca")
        button.setPreferredSymbolConfiguration(.init(pointSize: playButtonSize, weight: .regular, scale: .default), forImageIn: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = playButtonSize / 2
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        [timeSelectStackView, buttonStackView].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        timeSelectStackViewConstraints()
        
        timePickerStackViewConstraints()
        
        timePickerViewConstraints()
        restPickerViewConstraints()
        
        pickerDividerLabelConstraints()
        buttonStackViewConstraints()
    }
    
    private func timeSelectStackViewConstraints() {
        timeSelectStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeSelectStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            timeSelectStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func timePickerStackViewConstraints() {
        timePickerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timePickerStackView.heightAnchor.constraint(equalToConstant: 144)
        ])
    }
    
    private func pickerDividerLabelConstraints() {
        pickerDividerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pickerDividerLabel.widthAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    private func timePickerViewConstraints() {
        minutePickerView.translatesAutoresizingMaskIntoConstraints = false
        secondPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            minutePickerView.widthAnchor.constraint(equalToConstant: 80),
            secondPickerView.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func restPickerViewConstraints() {
        restPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            restPickerView.widthAnchor.constraint(equalToConstant: 240)
        ])
    }
    
    private func buttonStackViewConstraints() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24),
            buttonStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

extension UIColor {
    
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
