//
//  ProductDetailsViewModel.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-27.
//

import Foundation
import Combine
import SwiftUI

class ProductDetailsViewModel:ObservableObject{
    
    var compose = Set<AnyCancellable>()
    @Published var deviceId: String = ""
    @Published var size: String = ""
    @Published var color: String = ""
    @Published var displayName: String = ""
    @Published var isAddedToCart: Bool = false
    @Published var showError: Bool = false
    @Published var errorMsg: String = ""
    
    init(){
        self.deviceId = UserDefaults.standard.string(forKey: "deviceId") ?? ""
    }
    
    
    //load products data
    func addProductToCart(productId:String,displayName:String){
        
        if size.isEmpty || color.isEmpty {
            
            showError = true
            errorMsg = "Color and Size options should be selected"
            
        }else{
            
            let urlString = "https://style-pulse-b6aya.ondigitalocean.app/api/v1/cart"
            
            guard let url = URL(string: urlString) else {return}
            var request = URLRequest(url: url)
            
            let requestBody:[String:Any] = [
                "deviceId":self.deviceId,
                "username":"",
                "products":[
                    "productId":productId,
                    "varientId":"\(productId)_\(self.color)_\(self.size)",
                    "varient":[
                        "size":self.size,
                        "color":self.color
                    ],
                    "quantity":1,
                    "displayName":"\(displayName)"
                ]
            ]
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)
            
            let session = URLSession(configuration: .default)
            print(session)
            session.dataTaskPublisher(for: request)
                .map(\.data)
                .retry(3)
                .decode(type:ProductModel.self,decoder:JSONDecoder())
                .eraseToAnyPublisher()
                .receive(on: DispatchQueue.main)
                .sink{ res in
                    print(res)
                } receiveValue: {model in
                    print(model.status)
                    self.isAddedToCart = model.status
                    
                    if !self.isAddedToCart{
                        self.showError = true
                        self.errorMsg = "This option is already added to your cart"
                    }
                   
                }.store(in: &compose)
        }
    }
}
