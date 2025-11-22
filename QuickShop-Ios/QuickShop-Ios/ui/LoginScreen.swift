//
//  LoginScreen.swift
//  quickshop-ios
//
//  Created by Aabhash Shakya on 20/11/2025.
//

//

import SwiftUI

struct LoginScreen: View {
    @State private var username = ""
    @State private var password = ""
    @State private var usernameError: String? = nil
    @State private var passwordError: String? = nil

    var onLoginSuccess: (String) -> Void

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .center) {
                Color.surface
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: AppSpacing.large) {

                    // App Icon
                    Image("app_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .offset(x: -6)

                    // Welcome Text
                    Text("Welcome Back!")
                        .font(AppTypography.titleLarge)
                        .foregroundColor(.primary)

                    // Username Field
                    VStack(alignment: .leading, spacing: AppSpacing.small) {
                        TextField("Username", text: $username)
                            .padding()
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.primary, lineWidth: 1)
                            )
                            .accentColor(.primary) // cursor color


                        if let error = usernameError {
                            Text(error)
                                .foregroundColor(.red)
                                .font(AppTypography.labelSmall)
                                .frame(maxWidth: .infinity, alignment: .center)

                        }
                    }

                    // Password Field
                    VStack(alignment: .leading, spacing: AppSpacing.small) {
                        SecureField("Password", text: $password)
                            .padding()
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.primary, lineWidth: 1)
                            )
                            .accentColor(.primary) // cursor color


                        if let error = passwordError {
                            Text(error)
                                .foregroundColor(.red)
                                .font(AppTypography.labelSmall)
                                .frame(maxWidth: .infinity, alignment: .center)

                        }
                    }

                    // Login Button
                    Button(action: {
                        usernameError = username.isEmpty ? "Username cannot be empty" : nil
                        passwordError = password.isEmpty ? "Password cannot be empty" : nil

                        guard usernameError == nil, passwordError == nil else { return }

                            onLoginSuccess(UUID().uuidString)
                        
                    }) {
                     
                            Text("Login")
                                .font(AppTypography.bodyLarge)
                                .foregroundColor(.onPrimary)
                        
                    }
                    .frame(height: 50)
                    .padding(.horizontal, AppSpacing.large)
                    .background(Color.primary)
                    .cornerRadius(12)
                }
                .padding(.horizontal, AppSpacing.large)
            }
        }
    }
}
