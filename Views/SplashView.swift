//
//  SplashView.swift
//  TopPizza
//
//  Created by Yelzhan Yelikbaev on 25.07.2025.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.pink.ignoresSafeArea()
            Image("Logo")
                .renderingMode(.template)
                .resizable()
                .scaledToFill()
                .frame(width: 322, height: 103)
                .foregroundColor(.white)        }
    }
}

#Preview {
    SplashView()
}
