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
    func updateCredential(withType type: String) -> AnyPublisher<Void, APIError>
}

class UpdateCredentialsRepositoryImpl: UpdateCredentialsRepository {
    
    let networkingService: NetworkingService
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    func getCredentials() -> AnyPublisher<[Credential], APIError> {
        CoreDataManager.shared.fetchCredentials()
            .map { credentialsEntities in
                credentialsEntities.map { $0.toCredential() }
            }
            .eraseToAnyPublisher()
    }
    
    func updateCredential(withType type: String) -> AnyPublisher<Void, APIError> {
        networkingService.publisherForRequest(
            router: AccountRouter.updateCredentials,
            request: UpdateCredentialsRequest(type: type),
            responseType: CredentialResponse.self,
            encoder: NetworkParameterEncoder.json
        )
        .flatMap { credentialResponse -> AnyPublisher<Void, APIError> in
            guard let credential = credentialResponse.toCredential() else {
                return Fail(error: APIError.unknownError)
                    .eraseToAnyPublisher()
            }
            
            return CoreDataManager.shared.saveCredentialFromResponse(credential)
                .map { _ in }
                .eraseToAnyPublisher()
        }
        .mapError { error -> APIError in
            return APIError.statusMessage(message: error.localizedDescription)
        }
        .eraseToAnyPublisher()
    }
}
