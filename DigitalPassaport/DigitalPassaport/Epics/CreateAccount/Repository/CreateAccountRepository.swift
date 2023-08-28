//
//  CreateAccountRepository.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 24.8.23..
//

import Foundation
import Combine
import CoreData

<<<<<<< Updated upstream
protocol CreateAccountRepositoryType {
    func triggerApi()
=======
protocol CreateAccountRepository {
    func fetchData(parameters: APIRequestParameters?) -> AnyPublisher<AccountResponse, Error>
>>>>>>> Stashed changes
}

class CreateAccountRepositoryImp: CreateAccountRepository {
    
    private let networkingService: NetworkingService
    private let coreDataManager: CoreDataManager
    
    init(networkingService: NetworkingService, coreDataManager: CoreDataManager) {
        self.networkingService = networkingService
        self.coreDataManager = coreDataManager
    }

<<<<<<< Updated upstream
    func triggerApi() {
        let url = URL(string: APIEndpoints.account)!
        networkingService.post(url, parameters: [:])
            .sink(receiveCompletion: { completion in
                // Handle completion if needed
            }, receiveValue: { [weak self] data in
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    if let jsonDictionary = jsonObject as? [String: Any] {
                        var passes: [Pass] = []
                        var user: User?
                        
                        for (key, value) in jsonDictionary {
                            if key == "user", let userJSON = value as? [String: Any] {
                                if let userData = try? JSONSerialization.data(withJSONObject: userJSON) {
                                    user = try JSONDecoder().decode(User.self, from: userData)
                                }
                            } else if let passJSON = value as? [String: Any] {
                                if let passData = try? JSONSerialization.data(withJSONObject: passJSON) {
                                    let pass = try JSONDecoder().decode(Pass.self, from: passData)
                                    passes.append(pass)
                                }
                            }
                        }
                        
                        if let user = user {
                            DataManager.shared.saveUser(user)
                        }
                        if !passes.isEmpty {
                            DataManager.shared.savePasses(passes)
                        }
                    }
                } catch {
                    // Handle decoding error
                    print("Decoding error: \(error)")
                }
            })
            .store(in: &cancellables)
    }





}

struct DynamicCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?

    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }

    init?(intValue: Int) {
        self.stringValue = "\(intValue)"
        self.intValue = intValue
    }

    static func key(named name: String) -> DynamicCodingKey {
        return DynamicCodingKey(stringValue: name) ?? DynamicCodingKey(intValue: 0)!
=======
    func fetchData(parameters: APIRequestParameters?) -> AnyPublisher<AccountResponse, Error> {
        let url = URL(string: APIEndpoints.account)!
        
        return networkingService.post(url: url, parameters: parameters)
            .mapError { error -> Error in
                return error
            }
            .tryMap { accountResponse -> AccountResponse in
                print("tesst")
                self.coreDataManager.saveAccountResponse(accountResponse)
                return accountResponse
            }
            .eraseToAnyPublisher()
>>>>>>> Stashed changes
    }
}

