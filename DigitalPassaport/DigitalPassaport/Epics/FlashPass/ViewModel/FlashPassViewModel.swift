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
    private var repository: FlashPassRepository
    
    @Published var credentialsFromCoreData: [CredentialEntity] = []
    
    private var cancellables: Set<AnyCancellable> = []
    private var coreDataChangeCancellable: AnyCancellable?

    init(flashPassRepository: FlashPassRepository, selectedPass: Pass) {
        self.repository = flashPassRepository
        self.selectedPass = selectedPass
        
        
        Publishers.CombineLatest(repository.getUser(), repository.getCredentials())
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
        
        self.coreDataChangeCancellable = CoreDataManager.shared.credentialsChangesPublisher?.changesPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] credentialsEntities in
                var credentialsUpdated = credentialsEntities.map{$0.toCredential()}
                self?.credentials = credentialsUpdated
            })
    }
}
