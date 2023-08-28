//
//  APIRequestParameters.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 25.8.23..
//

import Foundation

struct APIRequestParameters: Encodable {
    let parameters: [String: Any]

    init(parameters: [String: Any]) {
        self.parameters = parameters
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let encodedData = try JSONSerialization.data(withJSONObject: parameters)
        try container.encode(encodedData, forKey: .parameters)
    }

    private enum CodingKeys: String, CodingKey {
        case parameters
    }
}
