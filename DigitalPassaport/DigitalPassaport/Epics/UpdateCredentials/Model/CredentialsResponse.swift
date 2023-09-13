//
//  CredentialsResponse.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 29.8.23..
//

import Foundation
import JWTDecode
import CoreData

struct CredentialResponse: Decodable{
    let type: String
    let jwt: String
    
    func toCredential() -> Credential? {
        do {
            let jwt = try JWTDecode.decode(jwt: self.jwt)
            let expirationTime = jwt.expiresAt
            
            let credential = Credential(type: self.type, expirationTime: expirationTime)
            return credential
        } catch {
            print("JWT Decoding Error: \(error)")
            return nil
        }
    }
}
