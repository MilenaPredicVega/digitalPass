//
//  DataManager.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 24.8.23..
//

import Foundation

class DataManager {
    static let shared = DataManager()
    private let userDefaults = UserDefaults.standard
    
    private init() {}
    
    func savePasses(_ passes: [Pass]) {
        do {
            let data = try JSONEncoder().encode(passes)
            userDefaults.set(data, forKey: "passes")
            print("Passes saved to UserDefaults: \(passes)")
        } catch {
            print("Error saving passes: \(error)")
        }
    }
    
    func getPasses() -> [Pass] {
        if let data = userDefaults.data(forKey: "passes") {
            do {
                return try JSONDecoder().decode([Pass].self, from: data)
            } catch {
                print("Error retrieving passes: \(error)")
            }
        }
        return []
    }
    
    func saveUser(_ user: User) {
        do {
            let data = try JSONEncoder().encode(user)
            userDefaults.set(data, forKey: "user")
        } catch {
            print("Error saving user: \(error)")
        }
    }
    
    func getUser() -> User? {
        if let data = userDefaults.data(forKey: "user") {
            do {
                return try JSONDecoder().decode(User.self, from: data)
            } catch {
                print("Error retrieving user: \(error)")
            }
        }
        return nil
    }
}

