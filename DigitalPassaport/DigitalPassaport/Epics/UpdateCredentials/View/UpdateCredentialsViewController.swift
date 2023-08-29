//
//  UpdateCredentialsViewController.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 23.8.23..
//

import UIKit

class UpdateCredentialsViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let updateTimeCredentials = CustomButton(type: .system)
    let updateReadyCredentials = CustomButton(type: .system)
  
    init() {
        super.init(nibName: nil, bundle: nil)
        updateTimeCredentials.addTarget(self, action: #selector(updateTimeCredentialsButtonTapped), for: .touchUpInside)
        updateReadyCredentials.addTarget(self, action: #selector(updateReadyCredentialsButtonTapped), for: .touchUpInside)
    }
   
   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

    }
    
    func setupViews() {
        self.view.backgroundColor = UIColor.backround
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(updateTimeCredentials)
        stackView.addArrangedSubview(updateReadyCredentials)
        
        updateTimeCredentials.translatesAutoresizingMaskIntoConstraints = false
        updateReadyCredentials.translatesAutoresizingMaskIntoConstraints = false
        
        updateTimeCredentials.setTitle("Update time credentials", for: .normal)
        updateReadyCredentials.setTitle("Update ready credentials", for: .normal)
        
        setUpNavigationBackButton()
        setupContrains()
    }
    
    func setupContrains() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateTimeCredentials.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            updateReadyCredentials.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
    }
    
    func setUpNavigationBackButton () {
        let leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "arrowLeft"),style: .done, target: self, action: #selector(FlashPassViewController.backTapped(sender:)))
        leftBarButtonItem.tintColor = .white
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc func backTapped(sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func updateTimeCredentialsButtonTapped() {
        print("Time updated")
    }
    
    @objc func updateReadyCredentialsButtonTapped() {
        print("Ready updated")
    }
    

}
