//
//  ProductListView.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-15.
//

import SwiftUI

struct ProductListView: View {
    @State private var isSplash = true
    var body: some View {
        ZStack{
            if(isSplash){
                SplashScreenView()
                    .transition(.opacity)
                    .animation(
                        Animation.easeInOut(duration: 4),
                        value:isSplash
                        
                    )
            }else{
                Text("Hi There")
            }
        }
        .onAppear{
            DispatchQueue.main
                .asyncAfter(deadline: .now()+3){
                    withAnimation{
                        self.isSplash = false
                    }
                }
        }
    }
}

#Preview {
    ProductListView()
}
