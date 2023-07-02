//
//  NetworkManager.swift
//  BestCoinPrice
//
//  Created by Артём Латушкин on 01.07.2023.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCoin(from url: URL, completion: @escaping(Result<CoinList, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let coins = try decoder.decode(CoinList.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(coins))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}

enum Link {
    case coinListLink
    
    var url: URL {
        switch self {
        case .coinListLink:
            return URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false")!
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
