//
//  ProductCardView.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-17.
//

import SwiftUI

struct ProductCardView: View {
    var body: some View {
        ZStack(alignment:.top){
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.white))
                .shadow(color: Color.black.opacity(0.1), radius: 7, x: 0, y: 0)
                .frame(width:180,height:280)
            
            VStack(alignment:.leading){
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.gray).opacity(0.2))
                   
                    .frame(width:180,height:250*0.75)
                    .overlay{
                        Image("main_banner_new")
                            .resizable()
                            .scaledToFit()
                            .frame(height:280*0.70)
                            .frame(width:180)
                            .clipShape(.rect(topLeadingRadius: 10,topTrailingRadius: 10))
                            
                    }.padding(.bottom,8)
                HStack(alignment:.center){
                    
                    Image(systemName: "star")
                        .font(.system(size: 13))
                        .foregroundColor(.yellow)
                    
                    Text("3.5")
                        .fontWeight(.regular)
                        .font(.system(size: 12))
                    
                }.offset(x:7)
                .padding(.bottom,1)
                
                Text("Red Frock-ladies dede")
                    .fontWeight(.semibold)
                    .font(.system(size: 14))
                    .padding(.bottom,1)
                    .offset(x:7)
                
                HStack{
                  
                    Text("Rs. 2000.00")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .foregroundColor(Color("navy_blue"))
                        
                }.offset(x:7)
                                
            }
            Spacer()
        }
     
    }
}

#Preview {
    ProductCardView()
}
