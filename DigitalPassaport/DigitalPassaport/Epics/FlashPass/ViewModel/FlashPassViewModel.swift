//
//  UserAccountViewModel.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 21.8.23..
//

import Combine

class FlashPassViewModel {
    @Published var selectedPass: Pass
    @Published var user: User
    
    init(selectedPass: Pass, user: User) {
        self.selectedPass = selectedPass
        self.user = DataManager.shared.getUser()!
    }
}


