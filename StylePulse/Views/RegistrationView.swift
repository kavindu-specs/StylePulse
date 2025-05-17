//
//  RegistrationView.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-20.
//

import SwiftUI

struct RegistrationView: View {
    @State var navigateToLogin: Bool = false
    @State var isNavigate: Bool = false
    @State var navigateToProductView:Bool = false
    @StateObject var registerVM: RegisterViewModel = RegisterViewModel()
    var body: some View {
        VStack{
            LoginHeaderView(title: "Register")
           
           Spacer()
            Image("logo_small")
                .resizable()
                .frame(width:180,height:80)
            Spacer()
            HStack{
                Text("Welcome")
                    .font(.system(size:23))
                    .fontWeight(.bold)
                Spacer()
            }.padding(.horizontal,15)
           
            HStack {
                Text("Keep connected with us for more experiences")
                    .foregroundColor(Color.gray.opacity(0.9))
                .fontWeight(.bold)
                Spacer()
            }.padding(.leading,15)
            
            //email
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                .foregroundColor(.gray)
                .frame(height:57)
                .padding()
                .overlay{
                    HStack(){
                        Image(systemName: "person")
                            .foregroundColor(.gray)
                            .frame(width:50, height:50)
                        TextField("Enter email",text: $registerVM.userName)
                        Spacer()
                        
                    }.padding(.leading,20)
                }
            
            //password
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                .foregroundColor(.gray)
                .frame(height:57)
                .padding()
                .overlay{
                    HStack(){
                        Image(systemName: "lock")
                            .foregroundColor(.gray)
                            .frame(width:50, height:50)
                        SecureField("Enter password",text: $registerVM.password)
                        Spacer()
                        
                    }.padding(.leading,20)
                }
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                .foregroundColor(.gray)
                .frame(height:57)
                .padding()
                .overlay{
                    HStack(){
                        Image(systemName: "lock")
                            .foregroundColor(.gray)
                            .frame(width:50, height:50)
                        SecureField("Re-Enter password",text: $registerVM.rePassword)
                        Spacer()
                        
                    }.padding(.leading,20)
                }
            if registerVM.showError{
                
                Text(registerVM.errorMessage).foregroundStyle(.red).padding()
            }
            Button(action:{
                registerVM.saveUser()
                self.navigateToLogin = false
                
            },label:{
                Text("SignIn")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .background{
                        RoundedRectangle(cornerRadius:10)
                            .frame(width:300,height:55)
                            
                    }
            }).padding()
                .foregroundColor(Color.black)
            
            NavigationLink("", isActive: $registerVM.success){
                ProductListView().navigationBarBackButtonHidden(true)
            }
            HStack{
                Text("Already have an account?")
                    .foregroundColor(.black)
                    .font(.caption)
                    .fontWeight(.medium)
                
                Text("login")
                    .foregroundColor(.blue)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        //self.isNavigate  = true
                        self.navigateToLogin = true
                    }
                NavigationLink("", isActive: $navigateToLogin){
                        LoginView().navigationBarBackButtonHidden(true)
                    
                }
            }.padding(.top,2)
            Divider().padding(25)
                Spacer()
                Spacer()
                Spacer()
            
           
            
        }.ignoresSafeArea()
    }
}

#Preview {
    RegistrationView()
}
