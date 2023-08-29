//
//  DataMapper.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 28.8.23..
//

import Foundation

struct DataMapper {
    
    static func mapPass(passItemCD: PassEntity) -> Pass {
        return Pass(id: passItemCD.id ?? "", name: passItemCD.name ?? "", description: passItemCD.descriptionCD ?? "", icon: passItemCD.icon ?? "")
    }
    
    static func mapUser(userCD: UserEntity) -> User {
        return User(firstName: userCD.firstName ?? "", lastName: userCD.lastName ?? "", email: userCD.email ?? "", image: userCD.image ?? "")
    }
}
