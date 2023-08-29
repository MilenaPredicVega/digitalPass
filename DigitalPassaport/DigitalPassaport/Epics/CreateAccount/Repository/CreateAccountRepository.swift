//
//  CreateAccountRepository.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 24.8.23..
//

import Foundation
import Combine
import Alamofire

protocol CreateAccountRepository {
    func fetchData(parameters: APIRequestParameters?) -> AnyPublisher<AccountResponse, Error>
}
class CreateAccountRepositoryImpl: CreateAccountRepository {
    
    private let coreDataManager: CoreDataManager
    private let networkingService: NetworkingService
    private var passes: [Pass] = []
    private var user: User?
    private var cancellables: Set<AnyCancellable> = []
    
    init(networkingService: NetworkingService, coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        self.networkingService = networkingService
    }
    func fetchData(parameters: APIRequestParameters?) -> AnyPublisher<AccountResponse, Error> {
        let url = URL(string: APIEndpoints.account)!
        
        return networkingService.post(url: url, parameters: parameters)
            .mapError { error -> Error in
                return error
            }
            .tryMap { accountResponse -> AccountResponse in
                self.coreDataManager.saveAccountResponse(accountResponse)
                return accountResponse
            }
            .eraseToAnyPublisher()
    }
}
