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
    private var cancellables: Set<AnyCancellable> = []
    
    init(repository: CreateAccountRepository) {
        self.repository = repository
    }
    
<<<<<<< Updated upstream
    func createAccountButtonTapped() {
        repository.triggerApi()
=======
    func createAccountButtonTapped(completion: @escaping (Bool) -> Void) {
        repository.fetchData(parameters: nil)
            .handleEvents(receiveOutput: { data in
               
            }, receiveCompletion: { recievedCompletion in
                switch recievedCompletion {
                case .finished:
                    completion(true)
                    print("API call completed")
                case .failure(let error):
                    completion(false)
                    print("API Error: \(error)")
                }
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .store(in: &cancellables)
>>>>>>> Stashed changes
    }
}
