//
//  DynamicCodingKey.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 25.8.23..
//

import Foundation

struct DynamicCodingKey: CodingKey {
    var stringValue: String
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    var intValue: Int? { return nil }
    init?(intValue: Int) { return nil }
}
