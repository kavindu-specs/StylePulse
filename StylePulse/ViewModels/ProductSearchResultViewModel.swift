//
//  ProductSearchResultViewModel.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-25.
//

import Foundation
import Combine

class ProductSearchResultViewModel: Observable{
    
    @Published var products:[Product] = []
    
    var compose = Set<AnyCancellable>()
    
    init(){
        
    }
    
    //load products data
    func loadProductsDataByCategory(category:String){
        print(category)
        let urlString = "https://style-pulse-b6aya.ondigitalocean.app/api/v1/products"
        
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        print(request)
        session.dataTaskPublisher(for: request)
            .map(\.data)
            .retry(3)
            .decode(type:ProductModel.self,decoder:JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink{ res in
            } receiveValue: {model in
                print(model.data)
                guard let productsArray = model.data else{return}
                self.products = productsArray
            }.store(in: &compose)
        
    }
}
