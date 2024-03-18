//
//  ProductListView.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-15.
//

import SwiftUI

struct ProductListView: View {
    @State private var isSplash = false
    var body: some View {
        ZStack{
            if(isSplash){
                SplashScreenView()
                    .transition(.opacity)
                    .animation(
                        Animation.easeInOut(duration: 5),
                        value:isSplash
                    )
            }else{
                GeometryReader{geo in
                    let topSafeArea = geo.safeAreaInsets.top
                    var columns = [GridItem(.adaptive(minimum:160),spacing:20)]
                    VStack{
                        Header(topSafeArea)
                        
                        ScrollView(.vertical){
                            Rectangle()
                                .frame(height:55)
                               
                                .overlay(
                                    Text("Experience our Amazing Styles..")
                                        .foregroundColor(Color.white)
                                        .bold()
                                    )

                            FullScreenBanner(bannerImage: "main_banner")
                            Rectangle()
                                .frame(height:40)
                               
                                .overlay(
                                    Text("Offers")
                                        .foregroundColor(Color.white)
                                        .bold()
                                    )

                            HalfScreenBanners(halfBannerImage1: "", halfBannerImage2: "")
                            Rectangle()
                                .fill(Color.gray.opacity(0.4))
                                .frame(height:40)
                               
                                .overlay(
                                    Text("New Arrivals")
                                        .foregroundColor(Color.black)
                                        .bold()
                                        .offset(x:-120)
                                        
                                    )

                            LazyVGrid(columns:columns,spacing:20){
                                ForEach(1...6,id:\.self){ x in
                                    ProductCardView()
                                }
                            }.padding(.horizontal,10)
                             .padding(.top,10)
                            
                            Rectangle()
                                .fill(Color.gray.opacity(0.4))
                                .frame(height:40)
                                .overlay(
                                    Text("More to love")
                                        .foregroundColor(Color.black)
                                        .bold()
                                        .offset(x:-120)
                                        
                                    )
                            LazyVGrid(columns:columns,spacing:20){
                                ForEach(1...6,id:\.self){ x in
                                    ProductCardView()
                                }
                            }.padding(.horizontal,10)
                             .padding(.top,10)
                            
                        }
                    }
                    .edgesIgnoringSafeArea(.top)
                    
                    
                    VStack{
                       Spacer()
                        BottomNavigationView()
                        
                    }
                }
            }
        }
        .onAppear{
            DispatchQueue.main
                .asyncAfter(deadline: .now()+4){
                    withAnimation{
                        self.isSplash = false
                    }
                }
        }
    }
    
    //HEADER view builder
    @ViewBuilder func Header(_ topsafeArea:CGFloat)->some View{
        VStack{
            
            HStack{
                Image("splashlogo")
                    .resizable()
                    .frame(width:220,height:110)
                    .offset(x:-65)
                Spacer()
                Image(systemName: "cart")
                    .imageScale(.large)
                    .offset(y:-9)
            }.padding(.horizontal,18).padding(.top,28)
            
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color(.gray).opacity(0.3))
                .frame(height:35)
                .padding(.horizontal,20)
                .overlay{
                    HStack{
                        TextField("Search Products",text:.constant(""))
                            .offset(x:28)
                        Image(systemName:"magnifyingglass")
                            .imageScale(.large)
                            .foregroundColor(Color(.gray).opacity(0.4))
                            .offset(x:-35)
                    }
                    
                }.offset(y:-10)
            
        }
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
    
    //Listing Banner: view builder
    @ViewBuilder func FullScreenBanner(bannerImage:String)->some View{
        RoundedRectangle(cornerRadius: 0)
            .fill(Color.white)
            .frame(height: 280)
            //.padding(.horizontal,5)
            .overlay{
                Image("main_banner_new")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 0))
            }
        
    }
    
    //Listing Banner: view builder
    @ViewBuilder func HalfScreenBanners(halfBannerImage1:String,halfBannerImage2:String)->some View{
        HStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(height: 350)
                .padding(.horizontal,5)
                .overlay{
                    Image("hat_banner")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(height: 350)
                .padding(.horizontal,5)
                .overlay{
                    Image("black_friday")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
        }.padding(.horizontal,12)
        
    }
    
}

#Preview {
    ProductListView()
}
