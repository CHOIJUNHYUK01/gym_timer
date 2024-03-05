//
//  RestView.swift
//  EclipseTimer
//
//  Created by CHOIJUNHYUK on 3/5/24.
//

import UIKit

class RestView: UIView {
    
    var restTime: Int? {
        didSet {
            guard let rt = restTime else { return }
            timeLabel.text = "\(rt)"
        }
    }
    
    private lazy var titleStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [titleLabel, timeLabel])
        st.axis = .horizontal
        st.distribution = .fill
        return st
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = .white
        label.text = "Resting"
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        label.textColor = .yellow
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
        [titleStackView].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        titleStackViewConstraints()
    }
    
    private func titleStackViewConstraints() {
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 36),
            titleStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }
}
