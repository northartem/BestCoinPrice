//
//  NetworkManager.swift
//  BestCoinPrice
//
//  Created by Артём Латушкин on 01.07.2023.
//

import Foundation

final class NetworkManager {
    static let shares = NetworkManager()
    
    private init() {}
    
    func fetchCharacter(from url: URL, completion: @escaping(Result<CoinList, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let coin = try decoder.decode(CoinList.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(coin))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

enum Link {
    case coinListLink
    
    var url: URL {
        switch self {
        case .coinListLink:
            return URL(string: "https://api.coincap.io/v2/assets")!
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
