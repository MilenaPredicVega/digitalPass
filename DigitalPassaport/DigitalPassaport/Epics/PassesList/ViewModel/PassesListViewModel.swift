//
//  PassesListViewModel.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 24.8.23..
//

import Combine
import Foundation

class PassesListViewModel {
    @Published var passes: [Pass]
    
    init() {
        self.passes = DataManager.shared.getPasses()
    }

}
