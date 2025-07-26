//
//  LoginPresenter.swift
//  TopPizza
//
//  Created by Yelzhan Yelikbaev on 25.07.2025.
//

import Foundation
import Combine


struct LoginNotification: Equatable {
    let message: String
    let isError: Bool
}

@MainActor
final class LoginPresenter: ObservableObject {
    
    private let interactor = LoginInteractor()
    
    @Published private(set) var isLoginSuccessful = false
    @Published var notification: LoginNotification? = nil

    func loginButtonTapped(user: String, pass: String) {
        
        notification = nil
        
        if interactor.performLogin(user: user, pass: pass) {

            notification = LoginNotification(message: "Успешный вход!", isError: false)
            isLoginSuccessful = true
        } else {

            notification = LoginNotification(message: "Неверный логин или пароль", isError: true)
        }
    }
}
