//
//  TimerView.swift
//  EclipseTimer
//
//  Created by CHOIJUNHYUK on 3/5/24.
//

import UIKit

class WorkingView: UIView {
    
    private var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 44, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 2
        label.text = "TAP Screen\nWhen You Rest"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        [titleLabel].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        titleLabelConstraints()
    }
    
    private func titleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 36),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 24)
        ])
    }
}
