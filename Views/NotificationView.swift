//
//  NotificationView.swift
//  TopPizza
//
//  Created by Yelzhan Yelikbaev on 25.07.2025.
//

import SwiftUI

struct NotificationView: View {
    let message: String
    let color: Color
    let iconName: String
    
    var body: some View {
        HStack(spacing: 16) {
            Text(message)
                .font(.headline)
                .fontWeight(.bold)
            
            Spacer()

            Image(systemName: iconName)
                .font(.title2)
        }
        .foregroundColor(color)
        .padding()
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(color, lineWidth: 2)
        )
        .padding(.horizontal)
    }
}

#Preview {
    VStack(spacing: 20) {
        NotificationView(
            message: "Успешный вход!",
            color: .green,
            iconName: "checkmark.circle.fill"
        )
        
        NotificationView(
            message: "Неверный логин или пароль",
            color: .red,
            iconName: "xmark.circle.fill"
        )
    }
    .padding()
}

#Preview {
    VStack(spacing: 20) {
        NotificationView(
            message: "Успешный вход!",
            color: .green,
            iconName: "checkmark.circle.fill"
        )
        
        NotificationView(
            message: "Неверный логин или пароль",
            color: .red,
            iconName: "xmark.circle.fill"
        )
    }
    .padding()
}
