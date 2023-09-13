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
        
        viewModel = CreateAccountViewModel(repository: CreateAccountRepositoryImpl(networkingService: NetworkingService(), coreDataManager: CoreDataManager.shared))
        
        self.createButton.layer.cornerRadius = 10
    }
    
    @IBAction func createAccountAction(_ sender: UIButton) {
        viewModel.createAccountButtonTapped { success in
            if success {
                DispatchQueue.main.async {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let passesListViewModel = PassesListViewModel(passesListRepository: PassesListRepositoryImpl(coreDataManager: appDelegate.coreDataManager))
                    let passesListViewController = PassesListViewController(viewModel: passesListViewModel)
                    self.navigationController?.pushViewController(passesListViewController, animated: true)
                }
            } else {
                APIAlerts.showAPIErrorAlert(on: self)
            }
        }
    }
}
