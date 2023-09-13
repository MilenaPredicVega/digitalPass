//
//  PassView.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 24.8.23..
//

import UIKit

class PassAccountView: UIView {
    
    private let mainHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let imageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let passImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
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
        setupContrains()
    }
    
    private func setupContrains() {
        setUpSubviews()
        
        NSLayoutConstraint.activate([
            mainHorizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainHorizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainHorizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainHorizontalStackView.topAnchor.constraint(equalTo: topAnchor),
            
            imageContainerView.leadingAnchor.constraint(equalTo: mainHorizontalStackView.leadingAnchor),
            imageContainerView.topAnchor.constraint(equalTo: mainHorizontalStackView.topAnchor),
            imageContainerView.bottomAnchor.constraint(equalTo: mainHorizontalStackView.bottomAnchor),
            imageContainerView.widthAnchor.constraint(equalTo: mainHorizontalStackView.widthAnchor, multiplier: 0.3),
            
            passImageView.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor),
            passImageView.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor),
            passImageView.heightAnchor.constraint(equalToConstant: 60),
            passImageView.widthAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func setUpSubviews() {
        imageContainerView.addSubview(passImageView)
        addSubview(mainHorizontalStackView)
        mainHorizontalStackView.addArrangedSubview(imageContainerView)
        mainHorizontalStackView.addArrangedSubview(textStackView)
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(descriptionLabel)
    }
    
    func configure (with passInfo: Pass) {
        titleLabel.text = passInfo.name
        descriptionLabel.text = passInfo.description
        
        if let iconBase64 = passInfo.icon, let iconData = Data(base64Encoded: iconBase64), let iconImage = UIImage(data: iconData) {
            passImageView.image = iconImage
        } else {
            passImageView.image = UIImage(systemName: "heart.fill") 
        }
    }
    
}
