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
    @Published var productsBycategory:[Product] = []
    @Published var banners:[Banner] = []
    @Published var categories:[Category] = []
   
    
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
                print(model.data)
                guard let bannersArray = model.data else{return}
                self.banners = bannersArray
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
                print(model.data)
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
    func loadProductsDataByCategory(category:String){
        
        let urlString = "https://style-pulse-b6aya.ondigitalocean.app/api/v1/products?category=\(category)"
        print(urlString)
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
                print(model.data)
                guard let productsArray = model.data else{return}
                self.productsBycategory = productsArray
            }.store(in: &compose)
        
    }
    
    func getDeviceID() -> String {
        guard let deviceId = UIDevice.current.identifierForVendor?.uuidString else {
            return ""
        }
        UserDefaults.standard.set(deviceId, forKey: "deviceId")
        print(deviceId)
        return deviceId
    }
    
    
}
