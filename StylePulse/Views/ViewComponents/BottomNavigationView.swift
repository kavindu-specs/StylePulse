//
//  BottomNavigationView.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-16.
//

import SwiftUI

struct BottomNavigationView: View {
    var body: some View {
        Spacer()
        RoundedRectangle(cornerRadius: 10)
            .fill(Color(.white))
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 0)
            .padding(.horizontal,10)
            
            .frame(height:55)
    }
}

#Preview {
    BottomNavigationView()
}
