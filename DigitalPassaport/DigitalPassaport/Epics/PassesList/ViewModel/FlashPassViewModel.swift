//
//  FlashPassViewModel.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 24.8.23..
//
import Foundation
import Combine

class FlashPassViewModel {
    @Published var selectedPass: Pass
    @Published var user: User
    private var repository: FlashPassRepository
    
    
    init(selectedPass: Pass, repository: FlashPassRepository) {
        self.repository = repository
        self.selectedPass = selectedPass
        self.user = self.repository.getUser()
    }
}
