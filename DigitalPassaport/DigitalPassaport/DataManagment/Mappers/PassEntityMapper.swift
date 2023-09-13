//
//  PassEntityMapper.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 29.8.23..
//

import Foundation

extension PassEntity {
    func toPass() -> Pass {
        return Pass(
            id: self.id ?? UUID(),
            name: self.name ?? "",
            description: self.descriptionCD ?? "",
            icon: self.icon ?? ""
        )
    }
}
