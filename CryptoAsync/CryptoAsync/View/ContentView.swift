//
//  ContentView.swift
//  CryptoAsync
//
//  Created by Yuliya  on 12/26/22.
//

import SwiftUI

struct ContentView: View {

    
    @ObservedObject var cryptoListViewModel: CryptoListViewModel

    init() {
        self.cryptoListViewModel = CryptoListViewModel()
    }
    
    var body: some View {
        NavigationView {
            List(cryptoListViewModel.cryptoList, id: \.id) { crypto in
                VStack {
                    Text(crypto.currency)
                        .font(.title3)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(crypto.price)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }.navigationTitle(Text("Crypto"))
        }.onAppear {
            cryptoListViewModel.downloadCryptos(url: URL(string: "")!)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
