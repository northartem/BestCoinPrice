//
//  Coin.swift
//  BestCoinPrice
//
//  Created by Артём Латушкин on 01.07.2023.
//

import Foundation

struct CoinList: Decodable {
    let data: [Coin]
}

struct Coin: Decodable {
    let id: String
    let name: String
    let priceUsd: String
    let changePercent24Hr: String
}
