//
//  TimerView.swift
//  EclipseTimer
//
//  Created by CHOIJUNHYUK on 3/5/24.
//

import UIKit
import Lottie

class WorkingView: UIView {
    
    // MARK: 타이틀
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 44, weight: .bold)
        label.textColor = .white
        label.text = "집중 중"
        return label
    }()
    
    // MARK: 로띠 관련 뷰
    private lazy var lottieContainerView: UIView = {
        let view = UIView()
        view.addSubview(animationView)
        return view
    }()
    
    private var animationView: LottieAnimationView = .init(name: "workingLottie")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        setConstraints()
        setLottieSetting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        [titleLabel, lottieContainerView].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        titleLabelConstraints()
        lottieContainerViewConstraints()
        animationViewConstraints()
    }
    
    private func titleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 36),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 24)
        ])
    }
    
    private func lottieContainerViewConstraints() {
        lottieContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lottieContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            lottieContainerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
            lottieContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lottieContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func animationViewConstraints() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        let screenSize: CGRect = UIScreen.main.bounds
        let lottieSize = screenSize.width * 2 / 3
        
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: lottieContainerView.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: lottieContainerView.centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: lottieSize),
            animationView.heightAnchor.constraint(equalToConstant: lottieSize)
        ])
    }
    
    private func setLottieSetting() {
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        animationView.contentMode = .scaleAspectFit
        animationView.play()
    }
}
