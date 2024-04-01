//
//  FIlterModalView.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-20.
//

import SwiftUI

struct FilterModalView: View {
    
    var products: [Product] = []
    var searchQuery: String = ""

    @Binding var isShowing: Bool
    @State private var curHeight : CGFloat = 700
    @State private var isLowestSelected = false
    @State private var isRatedSelected = false
    @State var navigate: Bool = false

    @StateObject  var filterVM: FilterViewModel = FilterViewModel()
    var body: some View {
        if isShowing{
            ZStack(alignment:.top){
              
                
                VStack(alignment:.leading){
                    HStack{
                        Text("Filter")
                            .bold()
                            .font(.system(size: 24))
                        Spacer()
                        Image(systemName: "xmark")
                            .foregroundColor(.black) // Set the color as needed
                            .imageScale(.large)
                            .onTapGesture {
                                self.isShowing = false
                            }
                        
                    }.padding(.horizontal,15)
                        .frame(height:80)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                  
                    Text("Sort By")
                        .bold()
                        .font(.system(size: 20))
                        .foregroundColor(Color.gray)
                        .padding(.horizontal,15)
                    
                    HStack{
    
                        Button(action: {
                            isLowestSelected.toggle()
                            isRatedSelected = isLowestSelected ? false:isRatedSelected
                        }) {
                            
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.white)
                                    .frame(width:110,height:30)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color(isLowestSelected ? .red : .black).opacity(0.4), lineWidth: 2)
                                                .overlay{
                                                    HStack{
                                                        Text("Lowest First")
                                                            .bold()
                                                            .font(.system(size: 15))
                                                            .foregroundColor(.black)
                                                        }
                                                }
                                        }
                        }
                        
                        Button(action: {
                            isRatedSelected.toggle()
                            isLowestSelected = isRatedSelected ? false:isLowestSelected
                        }) {
                            
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.white)
                                    .frame(width:110,height:30)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color(isRatedSelected ? .red : .black).opacity(0.4), lineWidth: 2)
                                                .overlay{
                                                    HStack{
                                                        Text("Most Rated")
                                                            .bold()
                                                            .font(.system(size: 15))
                                                            .foregroundColor(.black)
                                                        }
                                                }
                                        }
                        }
                    }.padding(.horizontal,12)
                     .padding(.bottom,18)
                    
                    Text("Price")
                        .bold()
                        .font(.system(size: 20))
                        .foregroundColor(Color.gray)
                        .padding(.horizontal,15)
                    
                    HStack(spacing:10){
                        
                        //low price
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(Color(.gray).opacity(0.1))
                            .frame(height:35)
                            .overlay{
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.black).opacity(0.2), lineWidth: 2)
                                    .overlay{
                                        HStack{
                                            TextField("Low",text: $filterVM.lowPrice)
                                                .keyboardType(.decimalPad)
                                                .offset(x:28)
                                        }
                                    }
                                
                            }
                        //high price
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(Color(.gray).opacity(0.1))
                            .frame(height:35)
                            .overlay{
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.black).opacity(0.2), lineWidth: 2)
                                    .overlay{
                                        HStack{
                                            TextField("High",text: $filterVM.highPrice)
                                                .keyboardType(.decimalPad)
                                                .offset(x:28)
                                        }
                                    }
                            }
                    }.padding(.horizontal,12)
                    Spacer()
                    HStack{
                        Spacer()
                        
                        Button(action: {
                            filterVM.filterProducts(lowestFirst: isLowestSelected, mostRated: isRatedSelected,products:products)
                            self.navigate = true
                           
                            
                        }) {
                            
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.black)
                                .frame(width:80,height:30)
                                .overlay{
                                    HStack{
                                        Text("Filter")
                                            .bold()
                                            .font(.system(size: 15))
                                            .foregroundColor(.white)
                                    }
                                }
                            
                        }
                       
                    }.padding(.horizontal,40)
                   Spacer()
                        
                }
                NavigationLink("", isActive: $navigate){
                   
                    ProductSearchResultView(products:filterVM.productsFilterResults,searchQuery:searchQuery)
                        .navigationBarBackButtonHidden(true)
                   
              
                }
            
            }
            .ignoresSafeArea()
            .frame(maxWidth:.infinity,maxHeight:.infinity,alignment:.bottom)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2) // Shadow for the entire view
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                }
            )
           
        }
    }
        
}

#Preview {
    ProductSearchResultView()
}
