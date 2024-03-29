//
//  File.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-28.
//

import Foundation
import SwiftUI
import Combine

class UserLoginViewModel:ObservableObject{
    
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var isUserVerified: Bool = false
    @Published var isNavigate: Bool = false
    
    var compose = Set<AnyCancellable>()

    func verifyUser(){
        
        print(userName)
        print(password)
       
        if userName.isEmpty || password.isEmpty{
            showError = true
            errorMessage = "Please enter username and password"
        }
        
        
        let urlString = "https://style-pulse-b6aya.ondigitalocean.app/api/v1/user/verify"

        guard let url = URL(string: urlString) else {return}
        var request = URLRequest(url: url)
        
        let requestBody:[String:Any] = [
            "username":userName,
            "password":password
        ]

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)
        
        let session = URLSession(configuration: .default)
        
        session.dataTaskPublisher(for: request)
            .map(\.data)
            .retry(3)
            .decode(type:UserRegisterModel.self,decoder:JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink{ res in
            } receiveValue: {model in
                print(model.status)
               
                self.isUserVerified = model.status
                
                if self.isUserVerified {
                    UserDefaults.standard.setValue(self.userName,forKey: "userName")
                }
            }.store(in: &compose)
    }

}
