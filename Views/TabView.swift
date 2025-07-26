//
//  TabView.swift
//  TopPizza
//
//  Created by Yelzhan Yelikbaev on 25.07.2025.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            menuTab
            contactsTab
            profileTab
            cartTab
        }
        .tint(.pink)
    }
}

// MARK: - Private Extensions
private extension AppTabView {
    
    var menuTab: some View {
        MainView()
            .tabItem {
                Label("Меню", systemImage: "menucard.fill")
            }
    }
    
    var contactsTab: some View {
        Text("Контакты")
            .tabItem {
                Label("Контакты", systemImage: "mappin.and.ellipse")
            }
    }
    
    var profileTab: some View {
        Text("Профиль")
            .tabItem {
                Label("Профиль", systemImage: "person.fill")
            }
    }
    
    var cartTab: some View {
        Text("Корзина")
            .tabItem {
                Label("Корзина", systemImage: "cart.fill")
            }
    }
}

#Preview {
    AppTabView()
}
