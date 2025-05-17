//
//  LoginView.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-20.
//

import SwiftUI

struct LoginView: View {
    @State var navigateToregister: Bool = false
    var title: String = "Welcome Back"
    @StateObject var loginVM: UserLoginViewModel = UserLoginViewModel()
    var body: some View {
        VStack{
            LoginHeaderView(title: "Login")
           
           Spacer()
            Image("logo_small")
                .resizable()
                .frame(width:180,height:80)
            Spacer()
            HStack{
                Text(title)
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
                        TextField("Enter email",text: $loginVM.userName)
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
                        SecureField("Enter password",text: $loginVM.password)
                        Spacer()
                        
                    }.padding(.leading,20)
                }
            
            if loginVM.showError{
                
                Text(loginVM.errorMessage).foregroundStyle(.red).padding()
            }
            
            Button(action:{
                loginVM.verifyUser()
                self.navigateToregister = false
            },label:{
                Text("Login")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.title)
                    .background{
                        RoundedRectangle(cornerRadius:10)
                            .frame(width:300,height:55)
                            
                    }
            }).padding()
                .foregroundColor(Color.black)
            
            NavigationLink("", isActive: $loginVM.isUserVerified){
                ProductListView().navigationBarBackButtonHidden(true)
            }
            
            HStack{
                Text("Don't have as account?")
                    .foregroundColor(.black)
                    .font(.caption)
                    .fontWeight(.medium)
                
                Text("Sign Up")
                    .foregroundColor(.blue)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .onTapGesture{
                        self.navigateToregister = true
                    }
            }.padding(.top,2)
            Divider().padding(25)
                Spacer()
                Spacer()
                Spacer()
            NavigationLink("", isActive: $navigateToregister){
                    RegistrationView().navigationBarBackButtonHidden(true)
            }
            
        }.ignoresSafeArea()
    }
}

#Preview {
    LoginView()
}
