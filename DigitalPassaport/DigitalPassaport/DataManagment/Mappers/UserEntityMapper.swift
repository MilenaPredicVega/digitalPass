//
//  UserEntityMapper.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 29.8.23..
//

import Foundation

extension UserEntity {
    func toUser() -> User {
        return User(
            firstName: self.firstName ?? "",
            lastName: self.lastName ?? "",
            email: self.email ?? "",
            image: self.image ?? ""
        )
    }
}
