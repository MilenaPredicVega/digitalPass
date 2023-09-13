//
//  PassesListViewModel.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 29.8.23..
//

import Combine
import Foundation

class PassesListViewModel {
    @Published var passes: [Pass] = []
    private var repository: PassesListRepository
    
    init(passesListRepository: PassesListRepository) {
        self.repository = passesListRepository
        repository.getPasses()
            .replaceError(with: []) 
            .receive(on: DispatchQueue.main)
            .assign(to: &$passes)
    }
}
