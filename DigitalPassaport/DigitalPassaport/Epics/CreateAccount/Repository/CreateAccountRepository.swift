//
//  CreateAccountRepository.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 24.8.23..
//

import Foundation
import Combine
import Alamofire

protocol CreateAccountRepositoryType {
    func triggerApi()
}

class CreateAccountRepository: CreateAccountRepositoryType {
    
    private let networkingService: NetworkingService
    private var passes: [Pass] = []
    private var user: User?
    private var cancellables: Set<AnyCancellable> = []
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }

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
    }
}
