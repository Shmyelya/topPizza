//
//  LoginInteractor.swift
//  TopPizza
//
//  Created by Yelzhan Yelikbaev on 25.07.2025.
//

import Foundation

class LoginInteractor {
    func performLogin(user: String, pass: String) -> Bool {
        guard user == "Qwerty123" && pass == "Qwerty123" else {
            return false
        }
        
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        return true
    }
}
