//
//  Crypto.swift
//  CryptoAsync
//
//  Created by Yuliya  on 12/26/22.
//

import Foundation

struct Crypto: Hashable, Decodable, Identifiable {
    
    let id = UUID()
    let currency: String
    let price: String
    
    private enum CodingKeys: String, CodingKey {
        case currency = "currency"
        case price = "price"
    }
}
