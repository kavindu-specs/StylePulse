//
//  ProductSearchResultView.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-19.
//

import SwiftUI

struct ProductSearchResultView: View {
    var body: some View {
        GeometryReader{geo in
            VStack{
                SearchHeaderView()
            }
            .edgesIgnoringSafeArea(.top)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    ProductSearchResultView()
}
