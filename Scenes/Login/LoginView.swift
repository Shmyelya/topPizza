//
//  LoginView.swift
//  TopPizza
//
//  Created by Yelzhan Yelikbaev on 25.07.2025.
//

import SwiftUI

struct LoginView: View {
    var onLoginSuccess: () -> Void
    
    @StateObject private var presenter = LoginPresenter()
    @State private var username = ""
    @State private var password = ""
    @State private var isPasswordVisible = false

    var body: some View {
        ZStack(alignment: .top) {
            navigationContent
            
            if let notification = presenter.notification {
                NotificationView(
                    message: notification.message,
                    color: notification.isError ? .red : .green,
                    iconName: notification.isError ? "xmark.circle.fill" : "checkmark.circle.fill"
                )
                .transition(.move(edge: .top).combined(with: .opacity))
                .padding(.top, 50)
            }
        }
        .onChange(of: presenter.isLoginSuccessful) { _, newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    onLoginSuccess()
                }
            }
        }
        .onChange(of: presenter.notification) { _, newNotification in
            if newNotification != nil {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        presenter.notification = nil
                    }
                }
            }
        }
    }
}

// MARK: - Private UI Components
private extension LoginView {
    
    var navigationContent: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                logo
                usernameField
                passwordField
                loginButton
                Spacer()
            }
            .padding()
            .navigationTitle("Авторизация")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var logo: some View {
        Image("Logo")
            .resizable()
            .scaledToFill()
            .frame(width: 322, height: 103)
    }
    
    var usernameField: some View {
        HStack {
            Image(systemName: "person")
                .foregroundColor(.gray)
            TextField("Ваш логин", text: $username)
                .textInputAutocapitalization(.never)
        }
        .modifier(CustomTextFieldStyle())
    }
    
    var passwordField: some View {
        HStack {
            Image(systemName: "lock")
                .foregroundColor(.gray)
            
            if isPasswordVisible {
                TextField("Ваш пароль", text: $password)
            } else {
                SecureField("Ваш пароль", text: $password)
            }
            
            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(.gray)
            }
        }
        .modifier(CustomTextFieldStyle())
    }
    
    var loginButton: some View {
        Button(action: {
            presenter.loginButtonTapped(user: username, pass: password)
        }) {
            Text("Войти")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.pink)
                .cornerRadius(10)
        }
    }
}

// MARK: - Custom View Modifier
private struct CustomTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
    }
}

#Preview {
    LoginView(onLoginSuccess: { print("Login successful in preview!") })
}

