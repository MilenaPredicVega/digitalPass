//
//  UpdateCredentialsRepository.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 29.8.23..
//

import Combine
import Foundation
import CoreData

protocol UpdateCredentialsRepository {
    func updateCredential(withType type: String,for selectedPass: Pass) -> AnyPublisher<Void, APIError>
}

class UpdateCredentialsRepositoryImpl: UpdateCredentialsRepository {
    
    let networkingService: NetworkingService
    let coreDataManager: CoreDataManager
    
    init(networkingService: NetworkingService, coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.networkingService = networkingService
        self.coreDataManager = coreDataManager
    }
    
    func updateCredential(withType type: String, for selectedPass: Pass) -> AnyPublisher<Void, APIError> {
        networkingService.publisherForRequest(
            router: AccountRouter.updateCredentials,
            request: UpdateCredentialsRequest(type: type),
            responseType: CredentialResponse.self,
            encoder: NetworkParameterEncoder.json
        )
        .flatMap { [weak self] credentialResponse -> AnyPublisher<Void, APIError> in
            guard let self = self else {
                return Fail(error: APIError.unknownError)
                    .eraseToAnyPublisher()
            }
            guard let credential = credentialResponse.toCredential() else {
                return Fail(error: APIError.unknownError)
                    .eraseToAnyPublisher()
            }
            return coreDataManager.saveCredentialFromResponse(credential, for: selectedPass.id)
                .map { _ in }
                .eraseToAnyPublisher()
        }
        .mapError { error -> APIError in
            return APIError.statusMessage(message: error.localizedDescription)
        }
        .eraseToAnyPublisher()
    }
}
