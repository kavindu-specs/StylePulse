//
//  SearchHeaderView.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-19.
//

import SwiftUI

struct SearchHeaderView: View {
    @State var navigate: Bool = false
    var body: some View {
        VStack{
            HStack{
                HStack{
                    Image(systemName: "chevron.left")
                        .resizable()
                        .padding(.leading,15)
                        .frame(width:24,height:22)
                    Text("Home")
                        .fontWeight(.regular)
                }.onTapGesture {
                    self.navigate = true
                }
                
                Spacer()
                Text("Explore Products")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .offset(x:-30)
                Spacer()
                
            }.padding(.bottom,18)
             
            NavigationLink("", isActive: $navigate){
               
                ProductListView(isSplash: false)
                    .navigationBarBackButtonHidden(true)
               
          
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
}

#Preview {
    SearchHeaderView()
}
