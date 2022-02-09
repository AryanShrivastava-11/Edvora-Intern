//
//  ContentView.swift
//  Edvora Homepage Test
//
//  Created by Aryan Shrivastava on 09/02/22.
//

import SwiftUI

let screen = UIScreen.main.bounds

struct ContentView: View {
    @ObservedObject var pm = ProductStore()
    @State var filterModeTurnedOn = false
    @State var productArray: [Product] = []
    
    var body: some View {
//        let keys = pm.productDict.map { $0.key }
//        let values = pm.productDict.map { $0.value }
        VStack {
            HStack {
                Text("Edvora")
                    .foregroundColor(.white)
                    .font(.system(size: 35, weight: .bold, design: .default))
                    .shadow(color: Color(uiColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)), radius: 4, x: 0, y: 4)
                    .onTapGesture {
                        pm.loadProduct()
                        filterModeTurnedOn = false
                    }
                Spacer()
            }
            
            FilterView(dict: pm.productDict, productNameArray: pm.keys, filterModeTurnedOn: $filterModeTurnedOn, didCompleteWithProduct: { index in
                filterModeTurnedOn = true
                productArray = pm.values[index]
            }, didCompleteProductsForSelectedState: { array in
                productArray = array
                filterModeTurnedOn = true
            }, didCompleteProductsForSelectedCities: { array in
                productArray = array
                filterModeTurnedOn = true
                
            } )
                .padding(.bottom)
            ScrollView(showsIndicators: false) {
                if filterModeTurnedOn{
                    ProductCategory(productArray: $productArray)
                }else{
                    ForEach(pm.keys.indices, id: \.self) { index in
                        ProductCategory(productArray: $pm.values[index])
                    }
                }
            }
        }
        .padding()
        .background(Color(#colorLiteral(red: 0.1607843137, green: 0.1607843137, blue: 0.1607843137, alpha: 1)))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct ProductCategory: View {
    @State var currentIndex: Int = 0
    @Binding var productArray: [Product]
    
    var body: some View {
        VStack(spacing: 15){
            HStack {
                Text(productArray.first?.product_name ?? "Product Name")
                    .foregroundColor(.white)
                    .font(.custom("SF Pro Display", size: 20))
                Spacer()
            }
            
            Divider()
                .background(.white)
            
            TabView(selection: $currentIndex)
//            ScrollView(.horizontal)
            {
//                HStack(spacing: 220) {
                    ForEach(productArray.indices, id: \.self){ index in
                        GeometryReader { geometry in
                            ProductDetail(product: productArray[index]
                            )
                                .padding(.bottom)
                                .tag(index)
                                .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX-20)/10), axis: (x: 0, y: -10, z: 0))
                                .padding(.leading, 80)
                                .padding(.top, 5)
                        }
                    }
//                }
            }
            .frame(height:200)
            .frame(maxWidth: screen.width)
            .tabViewStyle(.page(indexDisplayMode: .always))
//                                .background(.blue)
            
            
        }
    }
}

struct ProductDetail: View {
    var product: Product
    
    var body: some View {
        VStack( spacing: 13) {
            HStack(spacing: 20) {
                AsyncImage(url: URL(string: "\(product.image)")) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 70, height: 70)
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 5))

                VStack(alignment: .leading, spacing: 10) {
                    Text("\(product.product_name)")
                        .foregroundColor(.white)
                        .font(.custom("SF Pro Display", size: 15))
                        .frame(width:100,alignment: .leading)
                        .lineLimit(1)
                    Text("\(product.brand_name)")
                        .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)))
                        .font(.custom("SF Pro Display", size: 13))
                        .frame(width:100,alignment: .leading)
                        .lineLimit(1)
                    Text("$ \(product.price)")
                        .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1)))
                        .font(.custom("SF Pro Display", size: 13))
                        .frame(width:100,alignment: .leading)
                        .lineLimit(1)
                }
            }
            HStack {
                Text("\(product.address.city)")
                    .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)))
                    .font(.custom("SF Pro Display", size: 13))
                    .frame(width: 80,alignment: .leading)
                    .lineLimit(1)
                Text("Date: \(product.formattedDate)")
                    .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)))
                    .font(.custom("SF Pro Rounded", size: 13))
                    .lineLimit(1)
            }
            Text("\(product.discription)")
                .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)))
                .font(.custom("SF Pro Display", size: 11))
                .frame(width: 183,alignment: .leading)
                .lineLimit(1)
            
        }
        .frame(width: 210, height: 150)
        .background(.black)
        .cornerRadius(5)
    }
}
