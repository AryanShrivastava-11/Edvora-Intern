//
//  ProductViewModel.swift
//  Edvora Homepage Test
//
//  Created by Aryan Shrivastava on 09/02/22.
//

import SwiftUI
import Combine

class ProductStore: ObservableObject{
    @Published var productDict: [String: [Product]] = [:]
    @Published var keys: [String] = []
    @Published var values: [[Product]] = []
    
    
    init(){
        loadProduct()
    }
    
    func loadProduct(){
        guard let url = URL(string: "https://assessment-edvora.herokuapp.com/") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let err = error{
                print("Error in networking: \(err.localizedDescription)")
            }
            let productData = try! JSONDecoder().decode([Product].self, from: data!)
            DispatchQueue.main.async {
                self.productDict = self.parsingProductData(products: productData)
                self.keys = self.productDict.map{ $0.key }
                self.values = self.productDict.map{ $0.value }
//                print("\nKeys->\(self.keys)\n")
//                print("\nValues->\(self.values.count)\n")
            }
        }
        .resume()
    }
    
    func parsingProductData(products: [Product]) -> [String: [Product]]{
        var dict: [String: [Product]] = [:]
        
        for product in products {
            if (dict[product.product_name] == nil){
                dict[product.product_name] = [Product]()
                
            }
            dict[product.product_name]!.append(product)
        }
//        print(dict)
        
        return dict
    }
}


