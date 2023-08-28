//
//  AccountResponse.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 24.8.23..
//

import Foundation

struct AccountResponse {
    let user: User
    let passes: [Pass]
}

extension AccountResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case user
        case passes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let userContainer = try container.nestedContainer(keyedBy: DynamicCodingKey.self, forKey: .user)
        user = User.parse(from: userContainer)
        
        let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKey.self)
        passes = dynamicContainer.allKeys.compactMap { key in
            if key.stringValue.hasPrefix("pass"),
               let passContainer = try? dynamicContainer.nestedContainer(keyedBy: DynamicCodingKey.self, forKey: key) {
                return Pass.parse(from: passContainer)
            }
            return nil
            }
        }
    }
