//
//  FlashPassViewModel.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 30.8.23..
//

import Foundation
import Combine

class FlashPassViewModel {
    @Published var user: User = User(firstName: "", lastName: "", email: "", image: "")
    @Published var credentials: [Credential] = []
    var selectedPass: Pass
    var repository: FlashPassRepository
    
    @Published var credentialsFromCoreData: [CredentialEntity] = []
    
    private var cancellables: Set<AnyCancellable> = []
    private var coreDataChangeCancellable: AnyCancellable?

    init(flashPassRepository: FlashPassRepository, selectedPass: Pass) {
        self.repository = flashPassRepository
        self.selectedPass = selectedPass
        
        
        Publishers.CombineLatest(repository.getUser(), repository.getCredentials(selectedPass: selectedPass))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                 case .finished:
                     break
                 case .failure:
                    print(APIError.noData)
                 }
            }, receiveValue: { [weak self] user, credentials in
                self?.user = user
                self?.credentials = credentials
            })
            .store(in: &cancellables)
        
        repository.observeCredentialsChanges()
            .sink(receiveValue: { [weak self] credentialsEntities in
                
                self?.credentials = credentialsEntities
            })
            .store(in: &cancellables)
    }
    
    func areCredentialsValid(credentials: [Credential]) -> Bool {
        let defaultTime = Calendar.current.date(byAdding: .minute, value: -100, to: Date()) ?? Date()
        
        let isReadyValid = credentials.contains { credential in
            return credential.type == "READY" && (credential.expirationTime ?? defaultTime) > Date.now
        }
        
        let isTimeValid = credentials.contains { credential in
            return credential.type == "TIME" && (credential.expirationTime ?? defaultTime) > Date.now
        }
        
        return isReadyValid && isTimeValid
    }
}
