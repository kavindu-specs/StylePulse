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
               // .padding(.horizontal,10)
                .frame(width:180,height:250)
            VStack(alignment:.leading){
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.gray).opacity(0.2))
                   // .shadow(color: Color.black.opacity(0.3), radius: 7, x: 0, y: 0)
                   // .padding(.horizontal,10)
                    .frame(width:180,height:250*0.75)
                    .overlay{
                        Image("main_banner_new")
                            .resizable()
                            .scaledToFit()
                            .frame(height:250*0.75)
                            .frame(width:180)
                            .clipShape(.rect(topLeadingRadius: 10,topTrailingRadius: 10))
                            
                    }.padding(.bottom,8)


                  
                        Text("Red Frock")
                            .fontWeight(.semibold)
                            .font(.system(size: 15))
                            .padding(.bottom,1)
                            .offset(x:7)
                        
                        Text("Rs. 2000.00")
                            .fontWeight(.light)
                            .font(.system(size: 12))
                            .offset(x:7)

                    
                  
                
                
                                
            }
            Spacer()
        }
     
    }
}

#Preview {
    ProductCardView()
}
