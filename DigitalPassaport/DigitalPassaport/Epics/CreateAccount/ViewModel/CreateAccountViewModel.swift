//
//  CreateAccountViewModel.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 24.8.23..
//

import Foundation
import Combine

class CreateAccountViewModel {
    
    private let repository: CreateAccountRepository
    
    init(repository: CreateAccountRepository) {
        self.repository = repository
    }
    
    func createAccountButtonTapped() {
        repository.triggerApi()
    }
}
