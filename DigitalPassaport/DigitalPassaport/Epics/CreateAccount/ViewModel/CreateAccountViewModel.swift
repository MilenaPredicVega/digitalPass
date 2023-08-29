//
//  CreateAccountViewModel.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 24.8.23..
//

import Foundation
import Combine

class CreateAccountViewModel {
    
    private let repository: CreateAccountRepositoryImpl
    private var cancellables: Set<AnyCancellable> = []
    
    init(repository: CreateAccountRepositoryImpl) {
        self.repository = repository
    }
    
    func createAccountButtonTapped(completion: @escaping (Bool) -> Void) {
        repository.fetchData()
            .sink(receiveCompletion: { receivedCompletion in
                switch receivedCompletion {
                case .finished:
                    completion(true)
                case .failure(let error):
                    completion(false)
                    print("API Error: \(error)")
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
    }
}
