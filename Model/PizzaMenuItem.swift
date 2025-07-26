//
//  Pizza.swift
//  TopPizza
//
//  Created by Yelzhan Yelikbaev on 25.07.2025.
//

import Foundation

struct PizzaMenuItem: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let thumbnail: String
    let description: String
    let price: Double

    // Инициализатор для ручного создания (для превью)
    init(id: String, name: String, thumbnail: String, description: String, price: Double) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.description = description
        self.price = price
    }

    private enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnail = "strMealThumb"
    }

    // Инициализатор для декодирования из JSON
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
        self.description = "A delicious dish made with the finest ingredients."
        self.price = 9.99
    }
}
