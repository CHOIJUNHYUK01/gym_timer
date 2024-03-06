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
    private lazy var timeSelectStack: UIStackView = {
        let st = UIStackView(arrangedSubviews: [timeSelectLabel, timePickerStack, buttonStackView])
        st.axis = .vertical
        st.spacing = 20
        st.alignment = .fill
        return st
    }()
    
    // MARK: 시간 선택 타이틀
    private let timeSelectLabel: UILabel = {
        let label = UILabel()
        label.text = "쉬는 시간 설정"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    // MARK: 피커뷰 스택뷰
    private lazy var timePickerStack: UIStackView = {
        let st = UIStackView(arrangedSubviews: [minutePickerStackView, secondPickerStackView])
        st.axis = .horizontal
        st.spacing = 0
        st.distribution = .fillEqually
        return st
    }()
    
    // MARK: 분 선택 스택뷰
    private lazy var minutePickerStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [minutePickerView, minutePickerLabel])
        st.axis = .horizontal
        st.spacing = 0
        st.distribution = .fillEqually
        return st
    }()
    
    // MARK: 분 선택 피커뷰
    lazy var minutePickerView: UIPickerView = {
        let tp = UIPickerView()
        tp.backgroundColor = .black
        return tp
    }()
    
    private let minutePickerLabel: UILabel = {
        let label = UILabel()
        label.text = "분"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    // MARK: 초 선택 스택뷰
    private lazy var secondPickerStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [secondPickerView, secondPickerLabel])
        st.axis = .horizontal
        st.spacing = 0
        st.distribution = .fillEqually
        return st
    }()
    
    // MARK: 초 선택 피커뷰
    lazy var secondPickerView: UIPickerView = {
        let tp = UIPickerView()
        tp.backgroundColor = .black
        return tp
    }()
    
    private let secondPickerLabel: UILabel = {
        let label = UILabel()
        label.text = "초"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
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
        [timeSelectStack].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        timeSelectStackConstraints()
    }
    
    private func timeSelectStackConstraints() {
        timeSelectStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeSelectStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            timeSelectStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            timeSelectStack.centerYAnchor.constraint(equalTo: centerYAnchor)
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
