//
//  PassesListViewController.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 15.8.23..
//

import UIKit
import Combine

class PassesListViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    var viewModel: PassesListViewModel
    private var passes: [Pass] = []
    
// MARK: UI Components
    private var label: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font.withSize(10)
        label.textColor = .black
        return label
    }()
    

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.backround
        tableView.allowsSelection = true
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
// MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupBindings()
        self.setupUI()
    }
    
    init(viewModel: PassesListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBindings() {
        viewModel.$passes
            .sink { [weak self] newPasses in
                self?.passes = newPasses
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
// MARK: - SetUP UI
    
    private func setupUI() {
        self.view.backgroundColor = UIColor.backround
        self.navigationItem.hidesBackButton = true
        
        self.view.addSubview(tableView)
        self.view.addSubview(label)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
    }
}

// MARK: - Extension

extension PassesListViewController: UITableViewDelegate, UITableViewDataSource {
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passes.count
     }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        guard indexPath.row < passes.count else {
            return cell
        }
        let pass = passes[indexPath.row]
        cell.configure(with: pass)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < passes.count else {
            return
        }
        let selectedPass = passes[indexPath.row]
        var image = UIImage(systemName: "heart.fill")
        let user = User(firstName: "Milena", lastName: "Predic", email: "", image: "")
        let flashPassViewController = FlashPassViewController(viewModel: FlashPassViewModel(selectedPass: selectedPass, user: user))
        flashPassViewController.selectedPass = selectedPass
        navigationController?.pushViewController(flashPassViewController, animated: false)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}



