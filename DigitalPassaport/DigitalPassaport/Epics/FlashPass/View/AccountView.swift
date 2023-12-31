//
//  AccountViewController.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 18.8.23..
//

import UIKit
import Combine

class AccountView: UIView {
    private var selectedPass: Pass
    private var user: User
    private var readyExpirationTime: Date?
    private var timeExpirationTime: Date?
    
    private var passView = PassAccountView()
    private var timeView = CredentialsAccountView()
    private var readyView = CredentialsAccountView()
    private var userAccountView = UserAccountView()
    
    private let verticalMainStackView: UIStackView = {
        let verticalMainStackView = UIStackView()
        verticalMainStackView.axis = .vertical
        verticalMainStackView.alignment = .center
        verticalMainStackView.backgroundColor = UIColor.userBackground
        verticalMainStackView.spacing = 11
        return verticalMainStackView
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private let dividerViewBottom: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    init(selectedPass: Pass, user: User) {
        self.selectedPass = selectedPass
        self.user = user
        super.init(frame: .zero)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUser(_ user: User) {
        self.user = user
        userAccountView.configure(with: user)
    }
    func setExpirationTitles() {
        timeView.configureTitles(expirationLabelText: NSLocalizedString("TimeExpirationLabel", comment: ""))
        readyView.configureTitles(expirationLabelText: NSLocalizedString("ReadyExpirationLabel", comment: ""))

    }
    
    func setCredentials(_ credentials: [Credential]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd:MM:yyyy HH:mm"
        
        let credentialsByType = credentials.reduce(into: [String: Date]()) { result, credential in
            if let expirationTime = credential.expirationTime, !credential.type.isEmpty {
                result[credential.type] = expirationTime
            }
        }
        
        if let timeExpirationTime = credentialsByType[APIConstants.time] {
            timeView.configure(expirationValueText: dateFormatter.string(from: timeExpirationTime))
        }
        
        if let readyExpirationTime = credentialsByType[APIConstants.ready] {
            readyView.configure(expirationValueText: dateFormatter.string(from: readyExpirationTime))
        }
    }
    
    private func setUpView() {
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.userBackground
        
        setUpData()
        setExpirationTitles()
        setUpConstraints()
    }
    
    private func setUpData() {
        passView.configure(with: selectedPass)
      
    }
    
    private func setUpConstraints() {
        setupSubviews()
        
        NSLayoutConstraint.activate([
            verticalMainStackView.topAnchor.constraint(equalTo: topAnchor),
            verticalMainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            verticalMainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            verticalMainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            passView.heightAnchor.constraint(equalTo: verticalMainStackView.heightAnchor, multiplier: 0.17),
            passView.widthAnchor.constraint(equalTo: verticalMainStackView.widthAnchor),
            
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            dividerView.widthAnchor.constraint(equalTo: verticalMainStackView.widthAnchor, multiplier: 0.8),
            
            userAccountView.widthAnchor.constraint(equalTo: verticalMainStackView.widthAnchor, multiplier: 0.8),
            userAccountView.heightAnchor.constraint(equalTo: verticalMainStackView.heightAnchor, multiplier: 0.65),
            
            dividerViewBottom.heightAnchor.constraint(equalToConstant: 1),
            dividerViewBottom.widthAnchor.constraint(equalTo: verticalMainStackView.widthAnchor, multiplier: 0.8),
            
            timeView.leadingAnchor.constraint(equalTo: verticalMainStackView.leadingAnchor, constant: 10),
            timeView.trailingAnchor.constraint(equalTo: verticalMainStackView.trailingAnchor, constant: -10),
            readyView.leadingAnchor.constraint(equalTo: verticalMainStackView.leadingAnchor, constant: 10),
            readyView.trailingAnchor.constraint(equalTo: verticalMainStackView.trailingAnchor, constant: -10),
        ])
    }
    
    private func setupSubviews() {
        verticalMainStackView.translatesAutoresizingMaskIntoConstraints = false
        passView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerViewBottom.translatesAutoresizingMaskIntoConstraints = false
        userAccountView.translatesAutoresizingMaskIntoConstraints = false
        timeView.translatesAutoresizingMaskIntoConstraints = false
        readyView.translatesAutoresizingMaskIntoConstraints = false
        
        verticalMainStackView.addArrangedSubview(passView)
        verticalMainStackView.addArrangedSubview(dividerView)
        verticalMainStackView.addArrangedSubview(userAccountView)
        verticalMainStackView.addArrangedSubview(dividerViewBottom)
        verticalMainStackView.addArrangedSubview(timeView)
        verticalMainStackView.addArrangedSubview(readyView)
        
        addSubview(verticalMainStackView)
    }
    
}




