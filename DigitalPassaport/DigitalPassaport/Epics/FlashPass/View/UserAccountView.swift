//
//  UserAccountView.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 24.8.23..
//

import UIKit

class UserAccountView: UIView {
    
    private let checkMarkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private let userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private let userName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 2
        setupConstraints()
    }
    
    private func setupConstraints() {
        setUpSubviews()
        
        NSLayoutConstraint.activate([
            userName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            userName.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            userImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            userImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            userImage.heightAnchor.constraint(equalToConstant: 190),
            userImage.widthAnchor.constraint(equalToConstant: 190),
            
            checkMarkImage.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            checkMarkImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            checkMarkImage.heightAnchor.constraint(equalToConstant: 30),
            checkMarkImage.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setUpSubviews() {
        addSubview(checkMarkImage)
        addSubview(userImage)
        addSubview(userName)
    }
    
    func configure(with userInfo: User) {
        userName.text = userInfo.firstName + " " + userInfo.lastName
    }
    
}
