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
    
    init(){
        self.deviceId = UserDefaults.standard.string(forKey: "deviceId") ?? ""
    }
    
    
    //load products data
    func addProductToCart(productId:String,size:String,color:String,displayName:String){
        
        let urlString = "http://localhost:3000/api/v1/cart"

        guard let url = URL(string: urlString) else {return}
        var request = URLRequest(url: url)
        
        let requestBody:[String:Any] = [
            "deviceId":self.deviceId,
            "username":"",
            "products":[
                "productId":productId,
                "varient":[
                    "size":size,
                    "color":color
                ],
                "quantity":1,
                "displayName":displayName
            ]
        ]
        print(requestBody)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)
        
        let session = URLSession(configuration: .default)
        
        session.dataTaskPublisher(for: request)
            .map(\.data)
            .retry(3)
            .decode(type:ProductModel.self,decoder:JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink{ res in
            } receiveValue: {model in
                print(model.status)
                //guard let productsArray = model.data else{return}
               // self.products = productsArray
            }.store(in: &compose)
        
    }
}
