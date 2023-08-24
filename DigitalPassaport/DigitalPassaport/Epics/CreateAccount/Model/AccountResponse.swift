//
//  AccountResponse.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 24.8.23..
//

import Foundation

struct AccountResponse: Codable {
    let user: User
    let passes: [Pass] 
}
