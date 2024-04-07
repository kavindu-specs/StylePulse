//
//  BottomNavigationView.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-16.
//

import SwiftUI

struct BottomNavigationView: View {
      var isHome: Bool
      var isExplore: Bool
      var isCart: Bool
      var isProfile: Bool
    
    @State var isNavigateToCart: Bool = false
    @State var isNavigateToLogin: Bool = false
    @State var isNavigateToMain: Bool = false
    @State var isNavigate: Bool = false
    @State var isMenu: Bool = false
    
    var body: some View {
        Spacer()
        RoundedRectangle(cornerRadius: 10)
            .fill(Color(.white))
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 0)
            .padding(.horizontal,20)
            
            .frame(height:60)
            .overlay{
                HStack{
                    
                        if isHome{
                            VStack {
                                Image(systemName: "house.fill")
                                    .foregroundColor(Color("navy_blue"))
                                    .font(.system(size: 22))
                                Text("Home")
                                    .bold()
                                    .font(.system(size: 14))
                                    .foregroundColor(Color("navy_blue"))
                            }
                        }else{
                            VStack{
                                Image(systemName: "house.fill")
                                    .foregroundColor(.black)
                                    .font(.system(size: 22))
                                Text("Home")
                                    .bold()
                                    .font(.system(size: 14))
                            }.onTapGesture {
                                self.isNavigate  = true
                                self.isNavigateToCart  = false
                                self.isNavigateToLogin = false
                                self.isNavigateToMain = true
                            }
                        }
                       
                    
                   
                    Spacer()
                    VStack {
                        
                        if isProfile{
                            
                            Image(systemName: "person.fill")
                                .font(.system(size: 22))
                                .foregroundColor(Color("navy_blue"))
                            
                            Text("Account")
                                .bold()
                                .font(.system(size: 14))
                                .foregroundColor(Color("navy_blue"))
                            
                        }else{
                            if let userName = UserDefaults.standard.value(forKey: "userName") as? String {
                                
                                if !userName.isEmpty {
                                    
                                    Menu{
                                        Button(action: {
                                            UserDefaults.standard.setValue("",forKey: "userName")
                                            self.isNavigate  = true
                                            self.isNavigateToCart  = false
                                            self.isNavigateToLogin = true
                                            self.isNavigateToMain = false
                                        }) {
                                           Text("Logout")
                                                .bold()
                                            
                                        }
                                    }label:{
                                        VStack{
                                            Image(systemName: "person.fill")
                                                .foregroundColor(.black)
                                                .font(.system(size: 22))
                                            Text("Account")
                                                .bold()
                                                .font(.system(size: 14))
                                                .foregroundColor(Color(.black))
                                        }
                                    }
                                
                                } else {
                                    VStack{
                                        Image(systemName: "person.fill")
                                            .font(.system(size: 22))
                                            .foregroundColor(Color(.black))
                                        
                                        Text("Account")
                                            .bold()
                                            .font(.system(size: 14))
                                            .foregroundColor(Color(.black))
                                    }.onTapGesture {
                                        self.isNavigate  = true
                                        self.isNavigateToCart  = false
                                        self.isNavigateToLogin = true
                                        self.isNavigateToMain = false
                                    }
                                    
                                }
                            } else {
                                VStack{
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 22))
                                        .foregroundColor(Color(.black))
                                    
                                    Text("Account")
                                        .bold()
                                        .font(.system(size: 14))
                                        .foregroundColor(Color(.black))
                                }.onTapGesture {
                                        self.isNavigate  = true
                                        self.isNavigateToCart  = false
                                        self.isNavigateToLogin = true
                                       self.isNavigateToMain = false
                                    }
                                
                            }
                           
                        }
                        
                    }
                    Spacer()
                    VStack {
                        
                        if isCart{
                            
                            Image(systemName: "cart.fill")
                                .font(.system(size: 22))
                                .foregroundColor(Color("navy_blue"))
                            
                            Text("Cart")
                                .bold()
                                .font(.system(size: 14))
                                .foregroundColor(Color("navy_blue"))
                            
                        }else{
                            
                            Image(systemName: "cart.fill")
                                .foregroundColor(.black)
                                .font(.system(size: 22))
                            Text("Cart")
                                .bold()
                                .font(.system(size: 14))
                            
                        }
                        
                      
                    }.onTapGesture {
                        self.isNavigate  = true
                        self.isNavigateToCart  = true
                        self.isNavigateToLogin = false
                        self.isNavigateToMain = false
                    }
                }.padding(.horizontal,45)
            }
        
        //navigation
        NavigationLink("", isActive: $isNavigate){
            if isNavigateToCart{
                CartView()
            }else if isNavigateToLogin{
                LoginView().navigationBarBackButtonHidden(true)
            }else if isNavigateToMain{
                ProductListView(isSplash:false).navigationBarBackButtonHidden(true)
            }
            
        }
    }
}

#Preview {
    ProductListView()
}
