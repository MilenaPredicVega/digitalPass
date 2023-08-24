//
//  CreateAccountViewController.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 14.8.23..
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    private var viewModel: CreateAccountViewModel!
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let networkingService = NetworkingService()
        viewModel = CreateAccountViewModel(repository: CreateAccountRepository(networkingService: networkingService))
        self.createButton.layer.cornerRadius = 10
    }
    
    @IBAction func createAccountAction(_ sender: UIButton) {
        viewModel.createAccountButtonTapped()
        navigationController?.pushViewController(PassesListViewController(viewModel: PassesListViewModel()), animated: true)
    }
}
