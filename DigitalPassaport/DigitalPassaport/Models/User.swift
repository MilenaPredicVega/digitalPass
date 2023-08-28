//
//  User.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 18.8.23..
//
import Foundation

struct User {
    
    let firstName: String
    let lastName: String
    let email: String
    let image: String
}

extension User {
    static func parse(from container: KeyedDecodingContainer<DynamicCodingKey>) -> User {
        let firstName = try? container.decode(String.self, forKey: DynamicCodingKey(stringValue: "firstName")!)
        let lastName = try? container.decode(String.self, forKey: DynamicCodingKey(stringValue: "lastName")!)
        let email = try? container.decode(String.self, forKey: DynamicCodingKey(stringValue: "email")!)
        let image = try? container.decode(String.self, forKey: DynamicCodingKey(stringValue: "image")!)
        
        return User(firstName: firstName ?? "", lastName: lastName ?? "", email: email ?? "", image: image ?? "")
    }
}
