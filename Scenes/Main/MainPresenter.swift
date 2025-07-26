//
//  MainPresenter.swift
//  TopPizza
//
//  Created by Yelzhan Yelikbaev on 25.07.2025.
//

import Foundation
import Combine

@MainActor
class MainPresenter: ObservableObject {
    
    private let interactor = MainInteractor()
    
    @Published var viewModel: MainViewModel?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    init() {}
    
    init(stubbedViewModel: MainViewModel) {
        self.viewModel = stubbedViewModel
    }
    
    func fetchMenu() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let menu = try await interactor.fetchMenu()
            self.viewModel = MainViewModel(categories: menu)
        } catch {
            self.errorMessage = "Failed to load menu: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
