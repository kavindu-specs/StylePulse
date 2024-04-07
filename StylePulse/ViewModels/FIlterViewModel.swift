//
//  ProductSearchResultViewModel.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-25.
//

import Foundation
import Combine
import SwiftUI

class FilterViewModel: ObservableObject{
    
    //@Published var products:[Product] = []
    @Published var productsFilterResults:[Product] = []
    @Published var allProducts:[Product] = []
    @Published var lowPrice: String = "0"
    @Published var highPrice: String = "0"
    var compose = Set<AnyCancellable>()
    
    init(){
        
    }
    
    //load products data
    func filterProducts(lowestFirst:Bool,mostRated:Bool,products:[Product]){
     
        allProducts = products
        var resultProductsBySort: [Product] = products
       
        if mostRated{
            resultProductsBySort = products.sorted { (product1, product2) -> Bool in
                
                let rating1 = Double(String(format: "%.1f", product1.rating ?? 0)) ?? 0.0
                let rating2 = Double(String(format: "%.1f", product2.rating ?? 0)) ?? 0.0
                
                
                return rating1 > rating2
            }
        }else if lowestFirst {
            resultProductsBySort = products.sorted { (product1, product2) -> Bool in
                
                let price1 = Double(product1.defaultPrice)
                let price2 = Double(product2.defaultPrice)
                
                
                return price1  < price2
            }
            
        }
      
        if Double(lowPrice) ?? 0 > 0 || Double(highPrice) ?? 0  > 0 {
            
           resultProductsBySort = resultProductsBySort.filter { product in
               print(Double(product.defaultPrice))
               return Double(product.defaultPrice) >= Double(lowPrice) ?? 0 && Double(product.defaultPrice) <= Double(highPrice) ?? 0
                   
            }

        }
      print(resultProductsBySort)
        productsFilterResults = resultProductsBySort;
        

    }
    

}
