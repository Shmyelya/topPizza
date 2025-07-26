//
//  TopPizzaApp.swift
//  TopPizza
//
//  Created by Yelzhan Yelikbaev on 25.07.2025.
//

import SwiftUI

@main
struct TopPizzaApp: App {
    
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @State private var isSplashing = true
    
    var body: some Scene {
        WindowGroup {
            rootView
                .onAppear(perform: launch)
        }
    }
}

// MARK: - Private Extension
private extension TopPizzaApp {
    
    @ViewBuilder
    var rootView: some View {
        if isSplashing {
            SplashView()
        } else if isLoggedIn {
            AppTabView()
        } else {
            LoginView {
                withAnimation {
                    isLoggedIn = true
                }
            }
        }
    }
    
    func launch() {
        Task {
            try? await Task.sleep(for: .seconds(1.5))
            withAnimation(.easeInOut) {
                isSplashing = false
            }
        }
    }
}
