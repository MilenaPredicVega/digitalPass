//
//  CreateAccountViewController.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 14.8.23..
//

import UIKit
import CoreData

class CreateAccountViewController: UIViewController {
    
    private var viewModel: CreateAccountViewModel!
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let networkingService = NetworkingService()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        viewModel = CreateAccountViewModel(repository: CreateAccountRepositoryImp(networkingService: networkingService, coreDataManager: appDelegate.coreDataManager))
        self.createButton.layer.cornerRadius = 10
    }
    // TODO: Separate navigation logic
    @IBAction func createAccountAction(_ sender: UIButton) {
<<<<<<< Updated upstream
        viewModel.createAccountButtonTapped()
        navigationController?.pushViewController(PassesListViewController(viewModel: PassesListViewModel()), animated: true)
=======
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
>>>>>>> Stashed changes
    }
}
