//
//  UpdateCredentialsViewModel.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 29.8.23..
//
import Combine
import Foundation

class UpdateCredentialsViewModel: ObservableObject {
    @Published var credentials: [Credential] = []
    @Published var selectedPass: Pass
    
    private let repository: UpdateCredentialsRepositoryImpl
    private var cancellables: Set<AnyCancellable> = []
    
    init(repository: UpdateCredentialsRepositoryImpl, selectedPass: Pass) {
        self.repository = repository
        self.selectedPass = selectedPass
    }
    
    func updateCredentialsButtonTapped(withType type: String, completion: @escaping (Bool) -> Void) {
        repository.updateCredential(withType: type, for: selectedPass)
            .sink(receiveCompletion: { receivedCompletion in
                switch receivedCompletion {
                case .finished:
                    completion(true)
                case .failure(let error):
                    completion(false)
                    print("API Error: \(error.localizedDescription)")
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
    }
}
