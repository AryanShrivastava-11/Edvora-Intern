//
//  ProductView.swift
//  Edvora Homepage Test
//
//  Created by Aryan Shrivastava on 09/02/22.
//

import SwiftUI

struct ProductView: View {
    var body: some View {
        VStack( spacing: 14) {
            HStack(spacing: 20) {
                Image("Person")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 5))

                VStack(alignment: .leading, spacing: 10) {
                    Text("Product Name")
                        .foregroundColor(.white)
//                        .font(.system(size: 15, weight: .regular, design: .default))
                        .font(.custom("SF Pro Display", size: 15))
                        .frame(width:100,alignment: .leading)
                        .lineLimit(1)
                    Text("Brand Name")
                        .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)))
                        .font(.custom("SF Pro Display", size: 13))
                        .frame(width:100,alignment: .leading)
                        .lineLimit(1)
                    Text("$ 29.99")
                        .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1)))
                        .font(.custom("SF Pro Display", size: 13))
                        .frame(width:100,alignment: .leading)
                        .lineLimit(1)
                }
            }
            HStack {
                Text("Location")
                    .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)))
                    .font(.custom("SF Pro Display", size: 13))
                    .frame(width: 80,alignment: .leading)
                    .lineLimit(1)
                Text("Date: 10:12:2021")
                    .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)))
                    .font(.custom("SF Pro Rounded", size: 13))
                    .lineLimit(1)
            }
            Text("Description of the product/item.")
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

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}
