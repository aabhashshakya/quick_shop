//
//  PaymentSuccessView.swift
//  quickshop-ios
//
//  Created by Aabhash Shakya on 22/11/2025.
//

import Foundation
import SwiftUI
import Kingfisher


struct PaymentSuccessScreen: View {
    let product: Product
    let onContinueShopping: () -> Void

    var body: some View {
        ZStack{
            Color.surface.edgesIgnoringSafeArea(.all)
            
            VStack() {
                Text("Payment Successful!")
                    .font(.titleLarge)
                
                Spacer().frame(height: AppSpacing.large)
                
                KFImage(URL(string: product.image))
                    .resizable()
                
                    .frame(width: 140, height: 140)
                    .cornerRadius(16)
                Spacer().frame(height: AppSpacing.large)

                
                Text(product.title)
                    .font(.bodyLarge)
                Spacer().frame(height: AppSpacing.small)

                
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.titleLarge)
                    .foregroundColor(.primary)
                
                Spacer().frame(height: AppSpacing.large)

                
                Button(action: {
                    onContinueShopping()
                }) {
                    Text("Continue Shopping")
                        .font(.bodyLarge) 
                        .foregroundColor(Color.onPrimary)
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .background(Color.secondary)
                        .cornerRadius(32)
                }
            }
            .background(.surface)
            .padding()
        }
    }
}
