//
//  Category.swift
//  TopPizza
//
//  Created by Yelzhan Yelikbaev on 25.07.2025.
//

import Foundation

struct MenuCategory: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let thumbnail: String
    var items: [PizzaMenuItem]

    init(id: String, name: String, thumbnail: String, items: [PizzaMenuItem]) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.items = items
    }

    private enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case thumbnail = "strCategoryThumb"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
        self.items = []
    }
}
