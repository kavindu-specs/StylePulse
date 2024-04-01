//
//  CartViewModel.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-21.
//

import Foundation
import SwiftUI
import Combine

class CartViewModel:ObservableObject{
    var compose = Set<AnyCancellable>()
    
    @Published var deviceId: String = UserDefaults.standard.string(forKey: "deviceId") ?? ""
    
    @Published var cartData:CartData? = nil
    @Published var isLoadCart:Bool = false
    @Published var size: String = ""
    @Published var color: String = ""
    @Published var showError: Bool = false
    @Published var showSuccess: Bool = false
    @Published var errorMsg: String = ""
    @Published var successMsg: String = ""
    
    init(){
        
        loadCartDetails()
        
        
    }
    
    func getDeviceID() -> String {
        if let deviceId = UserDefaults.standard.string(forKey: "deviceId") {
            print("Device Identifier:", deviceId)
            return deviceId
        } else {
            print("Device identifier not found in UserDefaults")
            return ""
        }

    }
    
    //load cart details
    func loadCartDetails(){
        self.isLoadCart = true
       
        let urlString = "https://style-pulse-b6aya.ondigitalocean.app/api/v1/cart?deviceId=\(self.deviceId)"
        print(urlString)
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
  
        session.dataTaskPublisher(for: request)
            .map(\.data)
            .retry(3)
            .decode(type:CartModel.self,decoder:JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink{ res in
                //print(res)
                self.isLoadCart = false
            } receiveValue: {model in
                print(model.data)
                guard let cartDataReponse = model.data else{return}
                self.cartData = cartDataReponse
            }.store(in: &compose)
        
    }
    
    //delete cart details
    func deleteProduct(varientCode:String){
        print(self.deviceId)
        let urlString = "https://style-pulse-b6aya.ondigitalocean.app/api/v1/cart/\(self.deviceId)/\(varientCode)"
        print(urlString)
        guard let url = URL(string: urlString) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let session = URLSession(configuration: .default)
  
        session.dataTaskPublisher(for: request)
            .map(\.data)
            .retry(3)
            .decode(type:CartModel.self,decoder:JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink{ res in
                print(res)
            } receiveValue: {model in
                print(model.status)
                if model.data == nil {
                    
                }
                guard let cartDataReponse = model.data else{return}
               
                self.cartData = cartDataReponse
            }.store(in: &compose)
        
    }
    
    //update cart quantity
    func updateQuantity(varientCode:String,mark:String){
        
        print(self.deviceId)
        let urlString = "https://style-pulse-b6aya.ondigitalocean.app/api/v1/cart"
        print(urlString)
        guard let url = URL(string: urlString) else {return}
        var request = URLRequest(url: url)
        let requestBody:[String:Any] = [
            "deviceId":self.deviceId,
            "varientId":varientCode,
            "mark":mark
        ]
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)
        
        let session = URLSession(configuration: .default)
  
        session.dataTaskPublisher(for: request)
            .map(\.data)
            .retry(3)
            .decode(type:CartModel.self,decoder:JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink{ res in
                print(res)
            } receiveValue: {model in
                print(model.status)
                if model.data == nil {
                    self.loadCartDetails()
                }
                guard let cartDataReponse = model.data else{return}
               
                self.cartData = cartDataReponse
            }.store(in: &compose)
        
    }
    
    //update varient
    func updateVarient(varientCode:String,productId:String){
        
        print(self.deviceId)
        let urlString = "http://localhost:3000/api/v1/cart/varient"
        print(urlString)
        guard let url = URL(string: urlString) else {return}
        var request = URLRequest(url: url)
        let requestBody:[String:Any] = [
            "deviceId":self.deviceId,
            "varientId":varientCode,
            "newVarientId":"\(productId)_\(self.color)_\(self.size)",
            "size":self.size,
            "color":self.color
        ]
        print(requestBody)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)
        
        let session = URLSession(configuration: .default)
  
        session.dataTaskPublisher(for: request)
            .map(\.data)
            .retry(3)
            .decode(type:CartModel.self,decoder:JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink{ res in
                print(res)
            } receiveValue: {model in
                print(model.status)
                if model.status  {
                    self.showSuccess = true
                    self.successMsg = "Cart updated successfully"
                } else{
                    self.showError = true
                    self.successMsg = "Cart cannot be Updated"
                }
                guard let cartDataReponse = model.data else{return}
               
                self.cartData = cartDataReponse
            }.store(in: &compose)
        
    }
}
