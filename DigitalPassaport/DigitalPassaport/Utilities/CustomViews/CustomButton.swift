//
//  CustomButton.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 14.8.23..
//

import UIKit

class CustomButton: UIButton {

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupButton()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupButton()
        }

        private func setupButton() {
            backgroundColor = UIColor.button
            setTitleColor(.white, for: .normal)
            layer.cornerRadius = 10
            titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            self.heightAnchor.constraint(equalToConstant: 44).isActive = true
        }

        @objc private func buttonTapped() {
            
        }
    }

