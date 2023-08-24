//
//  CredentialsAccountView.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 24.8.23..
//

import UIKit

class CredentialsAccountView: UIView {
    
    private let mainHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    
    private let timeExpirationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
        }()
    
    private let timeExpirationValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        }()
    
    init(timeExpirationLabelText: String = "", timeExpirationValueText: String = "") {
        super.init(frame: .zero)
        timeExpirationLabel.text = timeExpirationLabelText
        timeExpirationValue.text = timeExpirationValueText
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.userBackground
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        setUpSubview()
        
        NSLayoutConstraint.activate([
            mainHorizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainHorizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainHorizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            mainHorizontalStackView.topAnchor.constraint(equalTo: topAnchor),
            ])
    }
    
    private func setUpSubview() {
        addSubview(mainHorizontalStackView)
        mainHorizontalStackView.addArrangedSubview(timeExpirationLabel)
        mainHorizontalStackView.addArrangedSubview(timeExpirationValue)
    }
    
    func configure(timeExpirationLabelText: String, timeExpirationValueText: String) {
        timeExpirationLabel.text = timeExpirationLabelText
        timeExpirationValue.text = timeExpirationValueText
    }
}
