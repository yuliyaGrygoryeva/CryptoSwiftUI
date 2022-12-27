//
//  WebService.swift
//  CryptoAsync
//
//  Created by Yuliya  on 12/26/22.
//

import Foundation

class WebService {
    
    /// starting iOS 15
   /* func downloadCurrenciesAsync(url: URL) async throws -> [Crypto] {
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let currencies = try? JSONDecoder().decode([Crypto].self, from: data)
        
        return currencies ?? []
    }
    */
    
    /// function to work with previous version of function, regular function
    func downloadCurrenciesContinuation(url: URL) async throws -> [Crypto] {
        try await withCheckedThrowingContinuation({ continuation in
            
            downloadCurrencies(url: url) { result in
                switch result {
                case .success(let cryptos):
                    continuation.resume(returning: cryptos ?? [])
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
    }
    
    
    /// Before iOS15 we are going to use dataTask
    
    func downloadCurrencies(url: URL, completion: @escaping (Result<[Crypto]?, DownloadedError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.badUrl))
            }
            
            guard let data = data, error ==  nil else {
                return completion(.failure(.noData))
            }
            
            guard let currencies = try? JSONDecoder().decode([Crypto].self, from: data) else {
                return completion(.failure(.dataParseError))
            }
            
            completion(.success(currencies))
            
        }.resume()
    }
}

enum DownloadedError: Error {
    case badUrl
    case noData
    case dataParseError
}
