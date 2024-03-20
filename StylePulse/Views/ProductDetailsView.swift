//
//  ProductDetailsView.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-17.
//

import SwiftUI

struct ProductDetailsView: View {
    var body: some View {
        ZStack {
            GeometryReader{geo in
                VStack{
                    productDetailsHeader()
                    
                    ScrollView(.vertical){
                        productImageCard()
                      
                       

                    }
                  
                    VStack{
                  
                       
                        
                    }
                }
                
                .edgesIgnoringSafeArea(.top)
                
            }
        }
    }
    
    
    @ViewBuilder func productDetailsHeader()->some View{
        //HEADER view builder
        VStack{
            HStack{
                
                Image(systemName: "chevron.left")
                    .resizable()
                    .padding(.leading,15)
                    .frame(width:24,height:22)
                
                Spacer()
                Text("Product Details")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
                
            }.padding(.bottom,18)

            HStack(){
                Text("Rs. 220.00")
                    .fontWeight(.bold)
                    .font(.system(size: 22))
                    .foregroundColor(.black)
                    .padding(.leading,14)
                Spacer()
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color("navy_blue"))
                    .frame(width:140,height:40)
                    .overlay{
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("navy_blue"), lineWidth: 2)
                         .overlay{
                             HStack{
                                 Text("Add to Cart")
                                     .bold()
                                     .foregroundColor(.white)
                                     
                                 Image(systemName: "chevron.right")
                                     .resizable()
                                     .padding(.leading,15)
                                     .foregroundColor(Color.white)
                                     .frame(width:22,height:22)
                             }
                         }
                    }.padding(.horizontal,15)
            }
          }
            .padding(.top,60)
            .padding(.bottom,5)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 0, style: .continuous)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2) // Shadow for the entire view
                    RoundedRectangle(cornerRadius: 0, style: .continuous)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                }
            )
            
    }
    
    @ViewBuilder func productImageCard()->some View{
        
        RoundedRectangle(cornerRadius: 6, style: .continuous)
            .fill(Color.gray.opacity(0.2))
            .overlay(
                Image("main_banner_new")
                    .resizable()
                    .scaledToFit()
                    
                   
               )
            .frame(height:350)
            .padding(.horizontal,10)
            .padding(.top,20)
            
    }
}

#Preview {
    ProductDetailsView()
}
