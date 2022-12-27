//
//  WebService.swift
//  CryptoAsync
//
//  Created by Yuliya  on 12/26/22.
//

import Foundation

class WebService {
    
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
