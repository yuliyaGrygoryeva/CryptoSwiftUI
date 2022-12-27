//
//  CryptoViewModel.swift
//  CryptoAsync
//
//  Created by Yuliya  on 12/26/22.
//

import Foundation

struct CryptoViewModel {
    let crypto: Crypto
    
    var id: UUID? {
        crypto.id
    }
    
    var currency: String {
        crypto.currency
    }
    
    var price: String {
        crypto.price
    }
}

class CryptoListViewModel: ObservableObject {
    
    @Published var cryptoList = [CryptoViewModel]()
    
    let webservice = WebService()
    
    func downloadCryptos(url: URL) {
        webservice.downloadCurrencies(url: url) { result in
            
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let cryptos):
                    if let cryptos = cryptos {
                        DispatchQueue.main.async {
                            self.cryptoList = cryptos.map(CryptoViewModel.init)
                        }
                }
            }
        }
    }
}
