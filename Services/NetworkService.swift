//
//  ManuDataService.swift
//  TopPizza
//
//  Created by Yelzhan Yelikbaev on 25.07.2025.
//

import Foundation

private struct CategoriesResponse: Codable {
    let categories: [MenuCategory]
}

private struct MealsResponse: Codable {
    let meals: [PizzaMenuItem]
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
}

final class NetworkService {
    
    private let baseURL = "https://www.themealdb.com/api/json/v1/1/"
    
    func fetchFullMenu() async throws -> [MenuCategory] {
        var categories = try await fetchCategories()
        
        try await withThrowingTaskGroup(of: (index: Int, items: [PizzaMenuItem]).self) { group in
            for (index, category) in categories.enumerated() {
                group.addTask {
                    let items = try await self.fetchItems(forCategory: category.name)
                    return (index, items)
                }
            }
            
            for try await (index, items) in group {
                categories[index].items = items
            }
        }
        
        return categories
    }
}

// MARK: - Private Helper Methods
private extension NetworkService {
    
    func fetchCategories() async throws -> [MenuCategory] {
        let urlString = baseURL + "categories.php"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let response = try JSONDecoder().decode(CategoriesResponse.self, from: data)
            return response.categories
        } catch {
            throw NetworkError.decodingFailed
        }
    }
    
    func fetchItems(forCategory categoryName: String) async throws -> [PizzaMenuItem] {
        let urlString = baseURL + "filter.php?c=\(categoryName)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let response = try JSONDecoder().decode(MealsResponse.self, from: data)
            return response.meals
        } catch {
             throw NetworkError.decodingFailed
        }
    }
}
