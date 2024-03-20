//
//  ProductSearchView.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-19.
//

import SwiftUI

struct ProductSearchView: View {
    var body: some View {
        GeometryReader{geo in
            VStack{
                searchHeader()
            }
            .edgesIgnoringSafeArea(.top)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    //search screen header
    @ViewBuilder func searchHeader()->some View{
        //HEADER view builder
        VStack{
            HStack{
                
                Image(systemName: "chevron.left")
                    .resizable()
                    .padding(.leading,15)
                    .frame(width:24,height:22)
                
                Spacer()
                Text("Explore Products")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
                
            }.padding(.bottom,18)

            HStack(){
                //seach bar
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color(.gray).opacity(0.3))
                    .frame(height:35)
                    .padding(.horizontal,20)
                    .overlay{
                        HStack{
                            TextField("Search Products",text:.constant(""))
                                .offset(x:28)
                            
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.white)
                                .frame(width:80,height:30)
                                .overlay{
                                    HStack{
                                        Text("Search")
                                            .bold()
                                            .font(.system(size: 15))
                                            .foregroundColor(.black)
                                            .offset(x:12)
                                            
                                        Image(systemName: "chevron.right")
                                            .resizable()
                                            .padding(.leading,15)
                                            .foregroundColor(Color.white)
                                            .frame(width:22,height:22)
                                    }
                                }.padding(.horizontal,22)
                        }
                        
                    }
                
                //cancel button
               Text("Cancel")
                    .bold()
                    .foregroundColor(.red)
                    .padding(.trailing,12)
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
}

#Preview {
    ProductSearchView()
}
