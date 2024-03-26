//
//  ProductCardView.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-17.
//

import SwiftUI

struct ProductCardView: View {
    @State var relevantProduct: Product?
    
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
                        Image(relevantProduct?.image ?? "")
                            .resizable()
                            .scaledToFit()
                            .frame(height:280*0.70)
                            .frame(width:180)
                            .clipShape(.rect(topLeadingRadius: 10,topTrailingRadius: 10))
                            
                    }.padding(.bottom,8)
                HStack(alignment:.center){
                    
                    Image(systemName: "star.fill")
                        .font(.system(size: 13))
                        .foregroundColor(.yellow)
                    
                    //Text("\(relevantProduct?.rating ?? 0)")
                    Text(String(format: "%.1f",relevantProduct?.rating ?? 0 ))
                        .fontWeight(.regular)
                        .font(.system(size: 12))
                    
                }.offset(x:7)
                .padding(.bottom,1)
                
                Text(relevantProduct?.name ?? "")
                    .fontWeight(.semibold)
                    .font(.system(size: 14))
                    .padding(.bottom,1)
                    .offset(x:7)
                
                HStack{
                  
                    Text("Rs.\(String(format: "%.2f", Double(relevantProduct?.defaultPrice ?? 0)))")
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
    ProductListView()
}
