//
//  FilterView.swift
//  Edvora Homepage Test
//
//  Created by Aryan Shrivastava on 09/02/22.
//

import SwiftUI

struct FilterView: View {
    @State var isExpandedFilter: Bool = false
    @State var isExpandedProduct: Bool = false
    @State var isExpandedState: Bool = false
    @State var isExpandedCity: Bool = false
    var dict: [String: [Product]] = [:]
    var productNameArray: [String]
    @State var stateArray: [String] = []
    @State var cityArray: [String] = []
    @State var selectedProductName = ""
    @State var selectedStateName = ""
    @Binding var filterModeTurnedOn: Bool
    @State var productsForSelectedState: [Product] = []
    @State var productsForSelectedCities: [Product] = []

    
    var didCompleteWithProduct: (Int) -> ()
    var didCompleteProductsForSelectedState: ([Product]) -> ()
    var didCompleteProductsForSelectedCities: ([Product]) -> ()

   
    func fetchStates(productName: String, index: Int) {
        if let productList = dict[productName] {
            let array = productList.map{ $0.address.state }.removingDuplicates()
            stateArray = array
        }
    }
    
    func fetchCities(index: Int) {
        var array: [String] = []
        if let productList = dict[selectedProductName]{
            for product in productList{
                if product.address.state == selectedStateName{
                    array.append(product.address.city)
                }
            }
            cityArray = array.removingDuplicates()
        }
    }
    
    func fetchingProductsForSelectedState() {
        if let values = dict[selectedProductName]{
            for product in values {
                if product.address.state == selectedStateName {
                    productsForSelectedState.append(product)
                }
            }
        }
    }
    

    var body: some View {
//        let keys = pm.productDict.map { $0.key }
//        let values = pm.productDict.map { $0.value }
        HStack {
            DisclosureGroup("Filters" , isExpanded: $isExpandedFilter) {
                DisclosureGroup("Products" , isExpanded: $isExpandedProduct) {
                    ScrollView {
                        ForEach(productNameArray.indices, id: \.self) { index in
                            VStack {
                                Button {
//                                    print("ProductArray:-> \(productNameArray)")
                                    
                                    stateArray.removeAll()
                                    cityArray.removeAll()
                                    
                                    fetchStates(productName: productNameArray[index], index: index)
                                    self.selectedProductName = productNameArray[index]
                                    
                                    didCompleteWithProduct(index)
                                    isExpandedProduct = false
                                } label: {
                                    Text("\(productNameArray[index])")
                                        .lineLimit(1)
                                }
                            .padding(.vertical,8)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .background(Color(#colorLiteral(red: 0.137254864, green: 0.1372548938, blue: 0.1372548938, alpha: 1)))
                .padding(.vertical,5)
                
                DisclosureGroup("State", isExpanded: $isExpandedState) {
                    ScrollView {
                        ForEach(stateArray.indices, id: \.self) { index in
                            
                            VStack {
                                Button {
                                    cityArray.removeAll()
                                    productsForSelectedState.removeAll()
                                    
                                    selectedStateName = stateArray[index]
                                    
                                    fetchCities(index: index)
                                    fetchingProductsForSelectedState()
                                    
                                    didCompleteProductsForSelectedState(productsForSelectedState)
                                    
                                    isExpandedState = false
                                } label: {
                                    Text("\(stateArray[index])")
                                        .lineLimit(1)
                                }
                                .padding(.vertical,8)
                            }
                            
                        }
                    }
                }
                .padding(.horizontal)
                .background(Color(#colorLiteral(red: 0.137254864, green: 0.1372548938, blue: 0.1372548938, alpha: 1)))
                .padding(.vertical,5)

                DisclosureGroup("City", isExpanded: $isExpandedCity) {
                    ScrollView {
                        ForEach(cityArray.indices, id: \.self) { index in
                            
                            VStack {
                                Button {
//                                    selectedProductName = ""
                                    productsForSelectedCities.removeAll()
                                    
                                    for product in productsForSelectedState{
                                        if product.address.city == cityArray[index]{
                                            productsForSelectedCities.append(product)
                                        }
                                    }
                                    
                                    didCompleteProductsForSelectedCities(productsForSelectedCities)
                                    
                                    isExpandedCity = false
                                } label: {
                                    Text("\(cityArray[index])")
                                        .lineLimit(1)
                                }
                                .padding(.vertical,8)
                            }
                            
                        }
                    }

                }
                .padding(.horizontal)
                .background(Color(#colorLiteral(red: 0.137254864, green: 0.1372548938, blue: 0.1372548938, alpha: 1)))
                .padding(.vertical,5)
            }
            .padding(.horizontal)
            .padding(.vertical,10)
            .background(Color(#colorLiteral(red: 0.07450980392, green: 0.07450980392, blue: 0.07450980392, alpha: 1)))
            
            .foregroundColor(.white)
//            .frame(width: 168.45, height: 37.5)
            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
            .frame(width: 230)
            .animation(.linear, value: 0.9)
            
            Spacer()
            
            Button {
                
                isExpandedFilter = false
                isExpandedProduct = false
                isExpandedState = false
                isExpandedCity = false
                
                stateArray.removeAll()
                cityArray.removeAll()
                
                selectedStateName = ""
                selectedProductName = ""
                
                productsForSelectedState = []
                
                filterModeTurnedOn = false
            } label: {
                Text("clear filter")
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical,10)
            .background(Color(#colorLiteral(red: 0.07450980392, green: 0.07450980392, blue: 0.07450980392, alpha: 1)))
            .cornerRadius(4)
            
        }
//        .padding(.horizontal)
    }
}


struct FilterUI_Previews: PreviewProvider {
    static var previews: some View {
//        FilterView()
        ContentView()
    }
}
