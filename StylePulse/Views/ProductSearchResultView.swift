//
//  ProductSearchResultView.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-19.
//

import SwiftUI

struct ProductSearchResultView: View {
    @State private var showModal = false
    var body: some View {
        GeometryReader{geo in
            let columns = [GridItem(.adaptive(minimum:160),spacing:20)]
            VStack{
                SearchHeaderView()
                    .padding(.bottom,15)
                ScrollView(.vertical){
                    VStack {
                        HStack(){
                            Text("Showing Results for Shirts")
                                .bold()
                                .font(.system(size: 20))
                           Spacer()
                            Image(systemName: "slider.horizontal.3")
                                           .resizable()
                                           .aspectRatio(contentMode: .fit)
                                           .frame(width: 30, height: 30)
                                           .foregroundColor(.black)
                                           .onTapGesture {
                                               self.showModal = true
                                           }
                        }.padding(.horizontal,15)
                            .padding(.vertical,20)
                        Divider()
                        
                        LazyVGrid(columns:columns,spacing:20){
                            ForEach(1...6,id:\.self){ x in
                                ProductCardView()
                            }
                        }.padding(.horizontal,10)
                         .padding(.top,10)
                            
                    
                        Spacer()
                    }
                }
                FIlterModalView(isShowing: $showModal)  
                    .transition(.move(edge:.bottom ))
                    .animation(
                        Animation.easeInOut(duration: 0.2)
                        )
               
            }
            .edgesIgnoringSafeArea(.top)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    ProductSearchResultView()
}
