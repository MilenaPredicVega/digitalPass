//
//  CredentialEntityMapper.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 31.8.23..
//

import Foundation

extension CredentialEntity {
    func toCredential() -> Credential {
        return Credential(
            type: self.type ?? "",
            expirationTime: self.expirationTime
        )
    }
}
