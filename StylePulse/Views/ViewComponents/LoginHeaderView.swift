//
//  LoginHeaderView.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-26.
//

import SwiftUI

struct LoginHeaderView: View {
    var body: some View {
        VStack{
          
            HStack{
                
                
      
                Text("Login")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.system(size:25))
                    .foregroundColor(Color.white)
                Spacer()
                
            }.padding(.bottom,10)
                .padding(.top,20)
                .padding(.horizontal,20)

        
          }
            .padding(.top,60)
            .padding(.bottom,5)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(Color.black.opacity(0.7))
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2) // Shadow for the entire view
                    RoundedRectangle(cornerRadius: 0, style: .continuous)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                }
            )    }
}

#Preview {
    LoginHeaderView()
}
