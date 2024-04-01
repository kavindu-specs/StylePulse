//
//  ProductDetailsView.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-17.
//

import SwiftUI

struct ProductDetailsView: View {
    
    @State var relevantProduct: Product?
    @State private var selectedSize: String?
    @State private var selectedColor: String?
    
    @StateObject var productsDetailsListVM: ProductDetailsViewModel = ProductDetailsViewModel()
    
    var body: some View {
        ZStack {
            GeometryReader{geo in
                VStack{
                    productDetailsHeader(productPrice: relevantProduct?.defaultPrice ?? 0)
                    
                    ScrollView(.vertical){
                        ScrollView(.horizontal){
                            HStack{
                                productImageCard(image:relevantProduct?.image ?? "")
                            }
                        }
                        productDetails(rating:relevantProduct?.rating ?? 0,name: relevantProduct?.name ?? "",note: relevantProduct?.specialNote ?? "",description:relevantProduct?.description ?? "",sizes:relevantProduct?.options?.sizes ?? [],colors:relevantProduct?.options?.colors ?? [],selectedSize: $selectedSize,selectedColor:$selectedColor)
                        Spacer()
                    }
                }
                
                .edgesIgnoringSafeArea(.top)
                
            }
            NavigationLink("", isActive: $productsDetailsListVM.isAddedToCart){
                    CartView()
            }
        }
    }
    
    
    @ViewBuilder func productDetailsHeader(productPrice:Int)->some View{
        //HEADER view builder
        VStack{
            HStack{
          
                Spacer()
                Text("Product Details")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
                
            }.padding(.bottom,18)

            HStack(){
               // Text("Rs. 220.00")
                Text("Rs.\(String(format: "%.2f", Double(productPrice)))")
                    .fontWeight(.bold)
                    .font(.system(size: 24))
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
                    .onTapGesture {
                        productsDetailsListVM.addProductToCart(productId: relevantProduct?.id ?? "", displayName: relevantProduct?.name ?? "")
                     
                    }
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
    
    //main image card
    @ViewBuilder func productImageCard(image:String)->some View{
        
        RoundedRectangle(cornerRadius: 6, style: .continuous)
            .fill(Color.gray.opacity(0.2))
            .overlay(
                
                Image(image)
                    .resizable()
                    .scaledToFit()
                  //  .padding(.horizontal,10)
                    
                   
               )
            .frame(width:400,height:350)
           // .padding(.horizontal,10)
            .padding(.top,20)
            
            
    }
    
    //main image card
    @ViewBuilder func productDetails(rating:Double,name:String,note:String,description:String,sizes:[String],colors:[String],
                                     selectedSize: Binding<String?>,selectedColor: Binding<String?>)->some View{
       // @State  var selectedSize: String?
        VStack(spacing:8){
            HStack{
                Image(systemName: "star.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.yellow)
            
                Text(String(format: "%.1f",rating))
                    .fontWeight(.regular)
                    .font(.system(size: 15))
                Spacer()
            }.padding(.horizontal,15)
            
            HStack {
                Text(name)
                    .bold()
                    .font(.system(size:20))
                Spacer()
            }.padding(.horizontal,15)
            HStack {
                Text(note)
                    .bold()
                    .foregroundColor(Color(.red))
                    .font(.system(size:14))
                Spacer()
            }.padding(.horizontal,15)
            Spacer()
                Divider()
            if productsDetailsListVM.showError{
                
                Text(productsDetailsListVM.errorMsg).bold().font(.system(size:14)).foregroundStyle(.red).padding(.horizontal)
            }
            //color options
            VStack{
                
                HStack{
                    Text("Colors")
                        .bold()
                        .foregroundColor(Color(.gray))
                        .font(.system(size:20))
                    Spacer()
                }.padding(.horizontal,15)
                
                ScrollView(.horizontal){
                    HStack(spacing:20){
                        ForEach(colors, id: \.self) { color in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(color))
                                //.border(Color.black,width:2)
                                .frame(width: 50, height: 50)
                                .onTapGesture {
                                    selectedColor.wrappedValue = color
                                    productsDetailsListVM.color = color
                                    print(color)
                                }
                                .border(selectedColor.wrappedValue == color ? Color.black.opacity(0.7) : Color.clear, width: 2)
                        }
                    }.padding(.horizontal,15)
                    
                }
            }.padding(.bottom,15)
            
            //size options
            VStack{
                
                HStack{
                    Text("Size")
                        .bold()
                        .foregroundColor(Color(.gray))
                        .font(.system(size:20))
                    Spacer()
                }.padding(.horizontal,15)
                
                ScrollView(.horizontal){
                    HStack(spacing:20){
                        ForEach(sizes, id: \.self) { size in
                            RoundedRectangle(cornerRadius: 10) // Half of the width
                                .fill(Color.gray.opacity(0.2))
                                //.border(Color.black,width:2)
                                .frame(width: 50, height: 50)
                                .overlay(
                                    Text(size)
                                        .bold()
                                        .font(.system(size:22))
                                        .foregroundColor(.black)
                                        
                                ).onTapGesture {
                                    selectedSize.wrappedValue = size
                                    productsDetailsListVM.size = size
                                    print(size)
                                }
                                .border(selectedSize.wrappedValue == size ? Color.black.opacity(0.7) : Color.clear, width: 2) // Border color based on selection
                        }
                    }.padding(.horizontal,15)
                    
                }
            }
            
            RoundedRectangle(cornerRadius: 0)
                .fill(Color.gray.opacity(0.1))
                .frame(height:100)
                .padding(.top,15)
                .overlay(
                    VStack{
                        Text(description)
                            .font(.system(size:14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.black.opacity(0.5))
                            
                    }.padding(.horizontal,15)
                        
                    )
        }.padding(.vertical,12)
            
    }
    
}

#Preview {
    ProductDetailsView()
}
