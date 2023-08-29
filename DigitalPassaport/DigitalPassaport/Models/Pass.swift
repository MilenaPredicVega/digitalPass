//
//  Pass.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 18.8.23..
//

import Foundation

//Domain Model
struct Pass {
    
    let id: String?
    let name: String
    let description: String
    let icon: String?
}

extension Pass {
    static func parse(from container: KeyedDecodingContainer<DynamicCodingKey>) -> Pass? {
        guard
            let name = try? container.decode(String.self, forKey: DynamicCodingKey(stringValue: "name")!),
            let description = try? container.decode(String.self, forKey: DynamicCodingKey(stringValue: "description")!),
            let icon = try? container.decode(String.self, forKey: DynamicCodingKey(stringValue: "icon")!)
        else {
            return nil
        }
        
        return Pass(id: container.allKeys.first?.stringValue, name: name, description: description, icon: icon)
    }
}
