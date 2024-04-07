//
//  BannerViewModel.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-20.
//




import Foundation
import SwiftUI
import Combine

class ProductListViewModel: ObservableObject {
    
    var compose = Set<AnyCancellable>()
    
    @Published var products:[Product] = []
    @Published var productsSearchResults:[Product] = []
    @Published var banners:Banner?
    @Published var categories:[Category] = []
    @Published var searchQuery: String = ""

    
    init(){
        print("calling")
        loadbannerData()
        loadCategoryData()
        loadProductsData()
        getDeviceID()
        
    }
    
    //laod banner data for listing page
    func loadbannerData(){
        let urlString = "https://style-pulse-b6aya.ondigitalocean.app/api/v1/contents/banners"

        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)

        session.dataTaskPublisher(for: request)
            .map(\.data)
            .retry(3)
            .decode(type:BannerModel.self,decoder:JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink{ res in
            } receiveValue: {model in
 
                //guard let bannersArray = model.data else{return}
                self.banners = model.data
            }.store(in: &compose)
        
    }
    
    //load category data
    func loadCategoryData(){
        let urlString = "https://style-pulse-b6aya.ondigitalocean.app/api/v1/categories"
        
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        
        session.dataTaskPublisher(for: request)
            .map(\.data)
            .retry(3)
            .decode(type:CategoryModel.self,decoder:JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink{ res in
            } receiveValue: {model in

                guard let categoriesArray = model.data else{return}
                self.categories = categoriesArray
               
            }.store(in: &compose)
        
    }
    
    //load products data
    func loadProductsData(){
        let urlString = "https://style-pulse-b6aya.ondigitalocean.app/api/v1/products"
        
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        
        session.dataTaskPublisher(for: request)
            .map(\.data)
            .retry(3)
            .decode(type:ProductModel.self,decoder:JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink{ res in
            } receiveValue: {model in
               // print(model.data)
                guard let productsArray = model.data else{return}
                self.products = productsArray
            }.store(in: &compose)
        
    }
    
    //load products data
    func loadProductsDataByCategory(category:String,categoryName:String){
        
        let urlString = "https://style-pulse-b6aya.ondigitalocean.app/api/v1/products?category=\(category)"

        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        
        session.dataTaskPublisher(for: request)
            .map(\.data)
            .retry(3)
            .decode(type:ProductModel.self,decoder:JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink{ res in
            } receiveValue: {model in

                guard let productsArray = model.data else{return}
                self.productsSearchResults = productsArray
                self.searchQuery = categoryName
            }.store(in: &compose)
        
        let filteredProducts = products.filter { product in
            return product.name!.lowercased().contains(self.searchQuery.lowercased())
        }

        self.productsSearchResults = filteredProducts
        
    }
    
    //load products data
    func searchProductsByquery(){
        

        let filteredProducts = products.filter { product in
            return product.name!.lowercased().contains(self.searchQuery.lowercased())
        }

        self.productsSearchResults = filteredProducts
        
    }
    
    func getDeviceID() -> String {
        guard let deviceId = UIDevice.current.identifierForVendor?.uuidString else {
            return ""
        }
        UserDefaults.standard.set(deviceId, forKey: "deviceId")
    
        return deviceId
    }
    
    
}
