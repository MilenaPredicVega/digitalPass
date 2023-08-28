//
//  MessageHelper.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 24.8.23..
//

import Foundation

struct MessageHelper {
    struct serverError {
        static let general : String = "Bad Request"
        static let noInternet : String = "Check the Connection"
        static let timeOut : String = "Timeout"
        static let notFound : String = "No Result"
        static let serverError : String = "Internal Server Error"
    }
}
