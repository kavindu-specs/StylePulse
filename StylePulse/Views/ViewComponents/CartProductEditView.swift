//
//  CartProductEditView.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-31.
//

import SwiftUI

struct CartProductEditView: View {
    
    @Binding  var isShowing:Bool
    var products: CartProduct?
    var cartVM : CartViewModel?
    
    @State private var selectedSize: String?
    @State private var selectedColor: String?
    var body: some View {
        if isShowing{
            ZStack(alignment:.top){
              
                
                VStack(alignment:.leading){
                    HStack{
                        Text("Edit Cart Item")
                            .bold()
                            .font(.system(size: 17))
                        Spacer()
                        Image(systemName: "xmark")
                            .foregroundColor(.black) // Set the color as needed
                            .imageScale(.large)
                            .onTapGesture {
                                self.isShowing = false
                            }
                        
                    }.padding(.horizontal,15)
                        .frame(height:40)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                  Divider()
                    VStack(alignment: .leading) {
                        Text(products?.displayName ?? "")
                            .font(.system(size:14))
                        HStack{
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color(products?.varient.color ?? ""))
                                .frame(width: 12, height: 12)
                            Text("Size - \(products?.varient.size ?? "")")
                                .font(.system(size:12))
                                .bold()
                                .padding(.horizontal,7)
                            
                        }
                    }.padding(.horizontal,15)
                        .padding(.vertical,10)
                    Divider()
                    VStack {
                        HStack {
                            Text("Colors")
                                .font(.system(size:14))
                            .bold()
                            Spacer()
                        }.padding(.horizontal,15)
                        ScrollView(.horizontal){
                            HStack(spacing:35){
                                ForEach(products?.productID.options.colors ?? [], id: \.self) { color in
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(color))
                                        //.border(Color.black,width:2)
                                        .frame(width: 40, height: 40)
                                        .onTapGesture {
                                            selectedColor = color
                                            cartVM?.color = color
                                          //  productsDetailsListVM.color = color
                                            print(color)
                                        }
                                        .border(selectedColor == color ?
                                                Color.black.opacity(0.7) : Color.clear, width: 2)
                                }
                            }.padding(.horizontal,15)
                            
                        }
                  
                        HStack {
                            Text("Sizes")
                                .font(.system(size:14))
                            .bold()
                            Spacer()
                        }.padding(.horizontal,15)
                        ScrollView(.horizontal){
                            HStack(spacing:35){
                                ForEach(products?.productID.options.sizes ?? [], id: \.self) { size in
                                    RoundedRectangle(cornerRadius: 10) // Half of the width
                                        .fill(Color.gray.opacity(0.2))
                                        //.border(Color.black,width:2)
                                        .frame(width: 40, height: 40)
                                        .overlay(
                                            Text(size)
                                                .bold()
                                                .font(.system(size:19))
                                                .foregroundColor(.black)
                                                
                                        ).onTapGesture {
                                            selectedSize = size
                                            cartVM?.size = size

                                            print(size)
                                        }
                                        .border(selectedSize == size ? Color.black.opacity(0.7) : Color.clear, width: 2) // Border color based on selection
                                }
                            }.padding(.horizontal,15)
                            
                        }
                        Button(action:{
                            cartVM?.updateVarient(varientCode: products?.varientID ?? "", productId: products?.productID.id ?? "")
                            self.isShowing = false
                        },label:{
                            Text("Edit Item")
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                                .background{
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color.black)
                                        .frame(width:130,height:40)
                                }
                        }).padding(.top,30)
                    }
                   
                       // Spacer()
                      
                   
                   
                   Spacer()
                        
                }
              
            
            }
            .ignoresSafeArea()
            .frame(maxWidth:.infinity,maxHeight:400,alignment:.bottom)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2) // Shadow for the entire view
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                }
            )
            .onAppear{
                self.selectedColor  = products?.varient.color
                self.selectedSize  = products?.varient.size
                cartVM?.color = products?.varient.color ?? ""
                cartVM?.size = products?.varient.size ?? ""
            }
           
        }
    }
}

#Preview {
    CartView()
}
