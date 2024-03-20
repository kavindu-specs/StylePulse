//
//  BannerViewModel.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-20.
//

import Foundation

import Foundation
import SwiftUI
import Combine

class ProductListViewModel: ObservableObject {
    
    var compose = Set<AnyCancellable>()
    
    @Published var banners:[Banner] = []
    @Published var categories:[Category] = []
    
    init(){
        loadbannerData()
        loadCategoryData()
    }
    
    //laod banner data for listing page
    func loadbannerData(){
        let urlString = "http://localhost:3000/api/v1/contents/banners"
        
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
        let urlString = "http://localhost:3000/api/v1/categories"
        
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
    
    //
}
