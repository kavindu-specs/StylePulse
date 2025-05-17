//
//  CartView.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-16.
//

import SwiftUI

struct CartView: View {
    
    @StateObject var cartListVM: CartViewModel = CartViewModel()
    @State private var isNavigateToMain:Bool = false
    
    @State  var isHomeSelected:Bool = false
    @State  var isExploreSelected:Bool = false
    @State  var isCartSelected:Bool = true
    @State  var isProfileSelected:Bool = false
    @State  var  showModal = false
    @State var product:CartProduct?
    
    var body: some View {
        ZStack {
            GeometryReader{geo in
                VStack{
                    
                    cartHeader(cartDetails: cartListVM)
                    
                    ScrollView(.vertical){
                        if cartListVM.showSuccess {
                       
                                Text(cartListVM.successMsg)
                                    .foregroundColor(Color.black)
                                    .font(.system(size:15))
                                    .bold()
                                    .animation(.easeInOut(duration: 1))
                                    .transition(.opacity)
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                            withAnimation{
                                                cartListVM.showSuccess = false
                                            }
                                        }
                                    }
                        }
                        
                        ForEach(cartListVM.cartData?.products ?? [],id:\.id){ product in
                            cartItemCard(cartProductDetails: product,cartVM:cartListVM)
                        }
                        
                        if !cartListVM.isLoadCart &&  cartListVM.cartData?.itemsCount ?? 0 == 0{
                            
                            emptyCartNotice()
                        }
                        
                        cartDeatails(cartDetails: cartListVM)
                        cartNotice()
                        checkoutButton().padding(.bottom,70)
                    }
                    
                    NavigationLink("", isActive: $isNavigateToMain){
                        ProductListView(isSplash:false).navigationBarBackButtonHidden(true)
                     }
                    }.edgesIgnoringSafeArea(.top)
                
            }
            
            VStack{
                Spacer()
                BottomNavigationView(isHome: isHomeSelected, isExplore: isExploreSelected, isCart: isCartSelected,isProfile: isProfileSelected)
            }
            
            VStack{
                Spacer()
                Spacer()
                CartProductEditView(isShowing: $showModal,products:product,cartVM:cartListVM)
                    .transition(.move(edge:.bottom ))
                    .animation(
                        Animation.easeInOut(duration: 0.2)
                        )
            } .edgesIgnoringSafeArea(.bottom)
            
        }
    }
    
    //Listing cartHeader view builder
    @ViewBuilder func cartHeader(cartDetails:CartViewModel)->some View{
      
        VStack{
            HStack{
           
                Spacer()
                Text("My Cart(\(cartDetails.cartData?.itemsCount ?? 0))")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    
                Spacer()
               
                
            }.padding(.bottom,18)

            HStack(){
                Text("Cart Total")
                    .fontWeight(.bold)
                    .font(.system(size: 22))
                    .foregroundColor(.black)
                    .padding(.leading,14)
                Spacer()
                Text("Rs.\(String(format: "%.2f", Double(cartDetails.cartData?.cartTotal ?? 0)))")
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                    .font(.title)
                    .foregroundColor(Color.black.opacity(0.7))
                    .padding(.trailing,10)
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
    
    //Cart Items Cards
    @ViewBuilder func cartItemCard(cartProductDetails:CartProduct,cartVM:CartViewModel)->some View{
        
        ZStack(alignment:.leading){
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(Color.white)
                .overlay(
                       RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        .overlay{
                            HStack{
                                Image(cartProductDetails.productID.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:110,height:110)
                                    .padding(.vertical,5)
                               
                                VStack(alignment: .leading) {
                                    Text(cartProductDetails.displayName)
                                        .font(.system(size:14))
                                    HStack{
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(Color(cartProductDetails.varient.color))
                                            .frame(width: 12, height: 12)
                                        Text("Size - \(cartProductDetails.varient.size)")
                                            .font(.system(size:12))
                                            .bold()
                                            .padding(.horizontal,7)
                                       
                                    }
                                        
                                    Text("Rs.\(String(format: "%.2f",Double(cartProductDetails.productID.defaultPrice)))")
                                        .font(.headline)
                                    
                                    HStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.white.opacity(0.1))
                                            .frame(width:70,height:30)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                 .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                                 .overlay{
                                                        HStack{
                                                            Button(action: {
                                                                cartVM.updateQuantity(varientCode: cartProductDetails.varientID, mark: "m")
                                                            }) {
                                                                Image(systemName: "minus")
                                                                    .foregroundColor(.blue)
                                                                    .font(.system(size: 15))
                                                            }.disabled(cartProductDetails.quantity == 1)
                                                            
                                                            Text("\(cartProductDetails.quantity)")
                                                                .font(.system(size:14))
                                                            
                                                            Button(action: {
                                                                cartVM.updateQuantity(varientCode: cartProductDetails.varientID, mark: "p")
                                                            }) {
                                                                Image(systemName: "plus")
                                                                    .foregroundColor(.blue)
                                                                    .font(.system(size: 15))
                                                            }
                                                    }
                                                 }
                                             
                                        )
                                        Image(systemName: "pencil")
                                                       .resizable()
                                                       .frame(width: 18, height: 18)
                                                       .foregroundColor(.blue)
                                                       .padding(.horizontal,8)
                                                       .onTapGesture {
                                                           self.showModal = true
                                                           self.product = cartProductDetails
                                                   }
                                    }
                                  }
                                .padding(.horizontal)
                                Spacer()
                                
                                Button(action: {
                                    cartVM.deleteProduct(varientCode:cartProductDetails.varientID)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                        .padding(.trailing)
                                }
                              
                            }
                        }
                   )
                .frame(height:150)
                .padding(.horizontal,10)
                .padding(.top,20)
                .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
        }
    }
    
    
    //Button
    @ViewBuilder func checkoutButton()->some View{
        
        Button(action:{
           
            },label:{
                Text("Checkout")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .background{
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.black)
                            .frame(width:340,height:50)
                        }
            }).padding()
      }
    
    
    //Cart Details
    @ViewBuilder func cartDeatails(cartDetails:CartViewModel)->some View{
        
        RoundedRectangle(cornerRadius: 0)
            .fill(Color.gray.opacity(0.1))
            .frame(height:150)
            .padding(.top,15)
            .overlay(
                VStack{
                    HStack{
                        Text("Sub Total")
                            .font(.system(size: 15))
                        Spacer()
                        Text("Rs. \(String(format: "%.2f",Double(cartDetails.cartData?.cartSubTotal ?? 0)))")
                            .font(.system(size: 15))
                            
                    }
                    HStack{
                        Text("Discount")
                            .font(.system(size: 15))
                        Spacer()
                        Text("Rs. \(String(format: "%.2f",Double(cartDetails.cartData?.discountTotal ?? 0)))")
                            .font(.system(size: 15))
                            
                    }
                    HStack{
                        Text("Tax")
                            .font(.system(size: 15))
                        Spacer()
                        Text("Rs. \(String(format: "%.2f",Double(cartDetails.cartData?.taxTotal ?? 0)))")
                            .font(.system(size: 15))
                            
                    }
                    Divider()
                        .background(.black)
                    HStack{
                        Text("Cart Total")
                            .font(.system(size: 18))
                        Spacer()
                        Text("Rs. \(String(format: "%.2f",Double(cartDetails.cartData?.cartTotal ?? 0)))")
                            .font(.system(size: 25))
                            .bold()
                    }
                }.padding(.horizontal,15)
                    
                )
    }
    
    //Cart Notice
    @ViewBuilder func cartNotice()->some View{
        
        RoundedRectangle(cornerRadius: 0)
            .fill(Color.gray.opacity(0.1))
            .frame(height:100)
            .padding(.top,15)
            .overlay(
                VStack{
                    Text("We accept following payment methods to assist your Journey")
                        .font(.system(size:14))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.black.opacity(0.5))
                        .multilineTextAlignment(.center)
                    HStack{
                        Image("cash_icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:25,height:25)
                        
                        Image("visa_icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:30,height:30)
                        Image("master_icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:30,height:30)
                            
                        
                    }
                }.padding(.horizontal,15)
                    
                )
    }
    
    //empty card notice
    @ViewBuilder func emptyCartNotice()->some View{
        
        VStack{
            
            Text("Oh! Your cart is empty")
                .font(.system(size:24))
                .fontWeight(.semibold)
                .foregroundColor(Color.black.opacity(0.5))
            Text("Add some Items to cart")
                .font(.system(size:16))
                .fontWeight(.medium)
                .foregroundColor(Color.black.opacity(0.5))
            Button(action:{
                self.isNavigateToMain = true
                },label:{
                    Text("Shop Now")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .background{
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.black)
                                .frame(width:260,height:50)
                            }
                }).padding()
        }.padding(.top,100)
            .padding(.bottom,30)
    }
    
    
    
    
}

#Preview {
    CartView()
}
