//
//  FlashPassViewController.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 18.8.23..
//

import UIKit
import Combine

class FlashPassViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    private var viewModel: FlashPassViewModel
    
     var selectedPass: Pass
     var user: User
     
    let accountView: AccountView
    let updateCredentialsButton = CustomButton(type: .system)
     
    init(viewModel: FlashPassViewModel) {
        self.viewModel = viewModel
        self.selectedPass = viewModel.selectedPass
        self.user = viewModel.user
        self.accountView = AccountView(selectedPass: viewModel.selectedPass, user: viewModel.user)
         
        super.init(nibName: nil, bundle: nil)
        updateCredentialsButton.addTarget(self, action: #selector(updateCredentialsButtonTapped), for: .touchUpInside)
     }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBindings()
        self.setupView()
    }
    
    private func setupBindings() {
        viewModel.$selectedPass
            .sink { [weak self] pass in
    // TODO: update ui
            }
            .store(in: &cancellables)
            
        viewModel.$user
            .sink { [weak self] user in
    // TODO: update ui
            }
            .store(in: &cancellables)
    }
    
    func setupView () {
        self.view.backgroundColor = UIColor.backround
        self.setUpNavigationBackButton()
        setUpContraints()
    }
    
    private func setUpContraints() {
        setUpSubviews()
        
        NSLayoutConstraint.activate([
            accountView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            accountView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            accountView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            updateCredentialsButton.topAnchor.constraint(equalTo: accountView.bottomAnchor, constant: 32),
            updateCredentialsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            updateCredentialsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            updateCredentialsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setUpSubviews() {
        view.addSubview(accountView)
        view.addSubview(updateCredentialsButton)
        
        accountView.translatesAutoresizingMaskIntoConstraints = false
        updateCredentialsButton.translatesAutoresizingMaskIntoConstraints = false
        updateCredentialsButton.setTitle("Update credentials", for: .normal)
    }
    
    func setUpNavigationBackButton () {
        let leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "arrowLeft"),style: .done, target: self, action: #selector(FlashPassViewController.backTapped(sender:)))
        leftBarButtonItem.tintColor = .white
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc func backTapped(sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func updateCredentialsButtonTapped() {
        let updateCredentials = UpdateCredentialsViewController()
        navigationController?.pushViewController(updateCredentials, animated: true)
    }

}
