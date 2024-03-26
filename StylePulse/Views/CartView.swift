//
//  CartView.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-16.
//

import SwiftUI

struct CartView: View {
    
    @StateObject var cartListVM: CartViewModel = CartViewModel()
    
    var body: some View {
        GeometryReader{geo in
            VStack{
                
                cartHeader(cartDetails: cartListVM)
                
                ScrollView(.vertical){
                   
                    ForEach(cartListVM.cartData?.products ?? [],id:\.id){ product in
                        cartItemCard(cartProductDetails: product)
                    }
                    
                    cartDeatails(cartDetails: cartListVM)
                    cartNotice()
                }
                
                ZStack {
                    checkoutButton()   // Content for the bottom position
                        }
                        .frame(width: geo.size.width, height: 100)
                        .edgesIgnoringSafeArea(.bottom)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: 0, style: .continuous)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                                  
                            }
                        )
            }
            
            .edgesIgnoringSafeArea(.top)
            .edgesIgnoringSafeArea(.bottom)
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
    @ViewBuilder func cartItemCard(cartProductDetails:CartProduct)->some View{
        
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
                                        
                                    Text("Rs.\(String(format: "%.2f",Double(cartProductDetails.productID.defaultPrice)))")
                                        .font(.headline)
                                    
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.white.opacity(0.1))
                                        .frame(width:70,height:30)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                             .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                             .overlay{
                                                    HStack{
                                                        Button(action: {
                                                                           
                                                        }) {
                                                            Image(systemName: "minus")
                                                                .foregroundColor(.blue)
                                                                .font(.system(size: 15))
                                                        }
                                                        
                                                        Text("\(cartProductDetails.quantity)")
                                                            .font(.system(size:14))
                                                        
                                                        Button(action: {
                                                                           
                                                        }) {
                                                            Image(systemName: "plus")
                                                                .foregroundColor(.blue)
                                                                .font(.system(size: 15))
                                                        }
                                                }
                                             }
                                         )
                                  }
                                .padding(.horizontal)
                                Spacer()

                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                                    .padding(.trailing)
                       
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
    
    
    
    
}

#Preview {
    CartView()
}
