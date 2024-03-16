//
//  SplashScreenView.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-15.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack{
            LinearGradient(gradient:Gradient(colors:[Color(.gray).opacity(0.4),.white]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Image("splashlogo")
                .resizable()
                .frame(width:600,height:300)
        }
    }
}

#Preview {
    SplashScreenView()
}
