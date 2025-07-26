//
//  PizzaScrollView.swift
//  TopPizza
//
//  Created by Yelzhan Yelikbaev on 25.07.2025.
//

import SwiftUI

struct MenuItemRowView: View {
    let item: PizzaMenuItem
    
    var body: some View {
        HStack(spacing: 16) {
            imageView
            infoView
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Private UI Components
private extension MenuItemRowView {
    
    var imageView: some View {
        AsyncImage(url: URL(string: item.thumbnail)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            case .failure:
                Image(systemName: "photo.artframe")
                    .foregroundColor(.gray)
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 100, height: 100)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
    }
    
    var infoView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.name)
                .font(.headline)
            
            Text(item.description)
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(2)
            
            priceView
        }
    }
    
    var priceView: some View {
        HStack {
            Spacer()
            Text(String(format: "$%.2f", item.price))
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.pink)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.pink, lineWidth: 1)
                )
        }
    }
}

#Preview {
    let sampleItem = PizzaMenuItem(
        id: "1",
        name: "Preview Pizza",
        thumbnail: "invalid-url", // Use invalid URL to test failure case
        description: "This is a sample description for the preview to test line limits and spacing.",
        price: 10.99
    )
    
    return MenuItemRowView(item: sampleItem)
        .padding()
}
