//
//  CartView.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-16.
//

import SwiftUI

struct CartView: View {
    var body: some View {
        GeometryReader{geo in
            VStack{
                
                cartHeader()
                ScrollView(.vertical){
                    cartItemCard()
                    cartItemCard()
                    cartItemCard()
                    cartItemCard()
                    cartDeatails()
                    cartNotice()
                   
                   //checkoutButton()
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
    
    //Listing Banner: view builder
    @ViewBuilder func cartHeader()->some View{
        //HEADER view builder
        VStack{
            HStack{
                
                Image(systemName: "chevron.left")
                    .resizable()
                    .padding(.leading,15)
                    .frame(width:24,height:22)
                
                Spacer()
                Text("My Cart")
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
                Text("Rs.222.00")
                    .fontWeight(.bold)
                    .font(.system(size: 22))
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
    @ViewBuilder func cartItemCard()->some View{
        
        ZStack(alignment:.leading){
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(Color.white)
                .overlay(
                       RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        .overlay{
                            HStack(spacing:20){
                       
                                Image("main_banner")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:130,height:130)
                                    .padding(.vertical,5)
                                    //.offset(y:10)
                               
                                Text("edc")
                       
                            }
                        }
                       
                   )
                .frame(height:150)
                .padding(.horizontal,10)
                .padding(.top,20)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            
       
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
    @ViewBuilder func cartDeatails()->some View{
        
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
                        Text("Rs.20.00")
                            .font(.system(size: 15))
                            
                    }
                    HStack{
                        Text("Discount")
                            .font(.system(size: 15))
                        Spacer()
                        Text("Rs.20.00")
                            .font(.system(size: 15))
                            
                    }
                    HStack{
                        Text("Tax")
                            .font(.system(size: 15))
                        Spacer()
                        Text("Rs.20.00")
                            .font(.system(size: 15))
                            
                    }
                    Divider()
                        .background(.black)
                    HStack{
                        Text("Cart Total")
                            .font(.system(size: 18))
                        Spacer()
                        Text("Rs.222.00")
                            .font(.system(size: 18))
                            .bold()
                            
                    }
                    
                }.padding(.horizontal,15)
                    
                )
           
    }
    
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
