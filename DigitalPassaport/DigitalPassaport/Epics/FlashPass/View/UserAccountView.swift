//
//  UserAccountView.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 24.8.23..
//

import UIKit

class UserAccountView: UIView {
    
    private let statusImage: UIImageView = {
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
            
            statusImage.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            statusImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            statusImage.heightAnchor.constraint(equalToConstant: 30),
            statusImage.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setUpSubviews() {
        addSubview(statusImage)
        addSubview(userImage)
        addSubview(userName)
    }
    
    func setStatusImage(_ imageName: String) {
        if let image = UIImage(named: imageName) {
            statusImage.image = image
        }
    }
    
    func configure(with userInfo: User) {
        userName.text = userInfo.firstName + " " + userInfo.lastName
        
        if let iconBase64 = userInfo.image, let iconData = Data(base64Encoded: iconBase64), let iconImage = UIImage(data: iconData) {
            userImage.image = iconImage
        } else {
            userImage.image = UIImage(systemName: "heart.fill")
        }
    }    
}
