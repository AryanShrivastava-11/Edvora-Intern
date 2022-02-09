//
//  ProductModel.swift
//  Edvora Homepage Test
//
//  Created by Aryan Shrivastava on 09/02/22.
//

import SwiftUI
import Combine

struct Product: Codable, Identifiable{
    let id = UUID()
    let product_name: String
    let brand_name: String
    let price: Int
    let address: Address
    let image: String
    let discription: String
    let date: String
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let newDate = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd:MM:YYY"
        return dateFormatter.string(from: newDate!)
    }
}
struct Address: Codable{
    let state: String
    let city: String
}

