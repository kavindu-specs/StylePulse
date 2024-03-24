//
//  ProductListView.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-15.
//

import SwiftUI

struct ProductListView: View {
    
    @State private var isSplash = true
    @State var navigate: Bool = false
    @State private var showModal = true
    
    @State  var isHomeSelected:Bool = true
    @State  var isExploreSelected:Bool = false
    @State  var isCartSelected:Bool = false
    
    @StateObject var productsListVM: ProductListViewModel = ProductListViewModel()
    
    var body: some View {
        ZStack{
            if(isSplash){
                
                //splash screen
                SplashScreenView()
                    .transition(.opacity)
                    .animation(
                        Animation.easeInOut(duration: 5),
                        value:isSplash
                    )
            }else{
                
                //listing screen
                GeometryReader{geo in
                    let topSafeArea = geo.safeAreaInsets.top
                    let columns = [GridItem(.adaptive(minimum:160),spacing:20)]
                    VStack{
                        
                            Header(topSafeArea).padding(.bottom, -10)
                        topHorizontalScroller(categories:productsListVM.categories)
                       
                        ScrollView(.vertical){
                            Rectangle()
                                .frame(height:55)
                                .overlay(
                                    Text("Experience our Amazing Styles..")
                                        .foregroundColor(Color.white)
                                        .bold()
                                    )

                            FullScreenBanner(banner: productsListVM.banners[0])
                            Rectangle()
                                .frame(height:40)
                               
                                .overlay(
                                    Text("Offers")
                                        .foregroundColor(Color.white)
                                        .bold()
                                    )

                            HalfScreenBanners(banners:productsListVM.banners[1])
                            Rectangle()
                                .fill(Color.gray.opacity(0.4))
                                .frame(height:40)
                               
                                .overlay(
                                    Text("New Arrivals")
                                        .foregroundColor(Color.black.opacity(0.6))
                                        .bold()
                                        .offset(x:-120)
                                    )
                            
                            //new products
                            LazyVGrid(columns:columns,spacing:20){
                                ForEach(productsListVM.products,id:\.id){ product in
                                    if product.isNewArrival == 1{
                                        ProductCardView(relevantProduct:product).onTapGesture {
                                            self.navigate=true
                                        }
                                    }
                                }
                            }.padding(.horizontal,10)
                             .padding(.top,10)
                            
                            Rectangle()
                                .fill(Color.gray.opacity(0.4))
                                .frame(height:40)
                                .overlay(
                                    Text("More to love")
                                        .foregroundColor(Color.black.opacity(0.6))
                                        .bold()
                                        .offset(x:-120)
                                        
                                    )
                            
                            //more to love products
                            LazyVGrid(columns:columns,spacing:20){
                                ForEach(productsListVM.products,id:\.id){ product in
                                    if product.isMoreToLove == 1{
                                        ProductCardView(relevantProduct:product).onTapGesture {
                                            self.navigate=true
                                        }
                                    }
                                }
                            }.padding(.horizontal,10)
                             .padding(.top,10)
                            
                        }
                    }
                    .edgesIgnoringSafeArea(.top)
                    
                    
                    VStack{
                       Spacer()
                        BottomNavigationView(isHome: isHomeSelected, isExplore: isExploreSelected, isCart: isCartSelected)
                            .padding(.bottom,7)
                        
                    }
                   
                }
               
            }
            
            NavigationLink("", isActive: $navigate){
                CartView()
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
                    .onTapGesture {
                        self.navigate  = true
                    }
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
       
        
        
    }
    
    //Listing Banner: view builder
    @ViewBuilder func FullScreenBanner(banner:Banner)->some View{
        RoundedRectangle(cornerRadius: 0)
            .fill(Color.white)
            .frame(height: 280)
            //.padding(.horizontal,5)
            .overlay{
                Image(banner.image[0] ?? "main_banner_new")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 0))
            }
        
    }
    
    //Listing Banner: view builder
    @ViewBuilder func HalfScreenBanners(banners:Banner)->some View{
        HStack{
            
            ForEach(banners.image, id: \.self) { image in
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(height: 350)
                    .padding(.horizontal,5)
                    .overlay{
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                
            }
          
        }.padding(.horizontal,12)
        
       
        
    }
    
    //top Scroller
    @ViewBuilder func topHorizontalScroller(categories:[Category])->some View{
        ScrollView(.horizontal, showsIndicators: false) {
            
                   HStack(spacing: 20) {
                       ForEach(categories, id: \.id) { category in
                           VStack {
                               Text(category.name)
                                   .font(.headline)
//                               Rectangle()
//                                       .frame(width: 35, height: 3) 
//                                       .foregroundColor(Color.black)
                           }
                           .frame(width: 70, height: 15)
                           .padding(.vertical,20)
                           .onTapGesture {
                              // <#code#>
                           }
                    
                       }
                   }
                   .padding(.leading,15)
                  
        }.frame(height:50)
            .background(Color.gray.opacity(0.3))
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 0, style: .continuous)
                               .fill(Color.white)
                               .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 5) // Shadow for the entire view
                           RoundedRectangle(cornerRadius: 0, style: .continuous)
                               .stroke(Color.gray.opacity(0.1), lineWidth: 2)

                }
            )
        
    }
    
}

#Preview {
    ProductListView()
}
