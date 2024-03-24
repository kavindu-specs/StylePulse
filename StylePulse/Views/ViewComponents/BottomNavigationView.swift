//
//  BottomNavigationView.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-16.
//

import SwiftUI

struct BottomNavigationView: View {
      var isHome: Bool
      var isExplore: Bool
      var isCart: Bool
    
    var body: some View {
        Spacer()
        RoundedRectangle(cornerRadius: 10)
            .fill(Color(.white))
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 0)
            .padding(.horizontal,20)
            
            .frame(height:60)
            .overlay{
                HStack{
                    
                    VStack {
                        if isHome{
                            Image(systemName: "house.fill")
                                .foregroundColor(Color("navy_blue"))
                                .font(.system(size: 22))
                            Text("Home")
                                .bold()
                                .font(.system(size: 14))
                                .foregroundColor(Color("navy_blue"))
                        }else{
                            Image(systemName: "house.fill")
                                .foregroundColor(.black)
                                .font(.system(size: 22))
                            Text("Home")
                                .bold()
                                .font(.system(size: 14))
                        }
                       
                     
                    }
                    Spacer()
                    VStack {
                        if isExplore{
                            
                            Image(systemName: "magnifyingglass")
                                   .font(.system(size: 22))
                                   .foregroundColor(Color("navy_blue"))
                            
                            Text("Explore")
                                .bold()
                                .font(.system(size: 14))
                                .foregroundColor(Color("navy_blue"))
                            
                        }else{
                            
                            Image(systemName: "magnifyingglass")
                                       .foregroundColor(.black)
                                   .font(.system(size: 22))
                            Text("Explore")
                                .bold()
                                .font(.system(size: 14))
                            
                        }
                        
                     
                    }
                    Spacer()
                    VStack {
                        
                        if isCart{
                            
                            Image(systemName: "cart.fill")
                                .font(.system(size: 22))
                                .foregroundColor(Color("navy_blue"))
                            
                            Text("Cart")
                                .bold()
                                .font(.system(size: 14))
                                .foregroundColor(Color("navy_blue"))
                            
                        }else{
                            
                            Image(systemName: "cart.fill")
                                .foregroundColor(.black)
                                .font(.system(size: 22))
                            Text("Cart")
                                .bold()
                                .font(.system(size: 14))
                            
                        }
                        
                      
                    }
                }.padding(.horizontal,45)
            }
    }
}

#Preview {
    ProductListView()
}
