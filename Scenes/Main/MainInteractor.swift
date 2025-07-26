//
//  MainInteractor.swift
//  TopPizza
//
//  Created by Yelzhan Yelikbaev on 25.07.2025.
//

import Foundation

class MainInteractor {
    private let networkService = NetworkService()
    
    func fetchMenu() async throws -> [MenuCategory] {
        return try await networkService.fetchFullMenu()
    }
}
