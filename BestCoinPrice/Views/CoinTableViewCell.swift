//
//  CoinTableViewCell.swift
//  BestCoinPrice
//
//  Created by Артём Латушкин on 01.07.2023.
//

import UIKit

class CoinTableViewCell: UITableViewCell {

    @IBOutlet var logoImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var changeLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    func configure(with coin: Coin) {
        nameLabel.text = coin.name
        changeLabel.text = "\(String(format: "%.2f", Double(coin.changePercent24Hr) ?? 0.0))%"
        priceLabel.text = String(format: "%.2f", Double(coin.priceUsd) ?? 0.0)
        
        let color = changePrice(with: coin)
        changeLabel.textColor = color
    }
}

extension CoinTableViewCell {
    private func changePrice(with coin: Coin) -> UIColor {
        if Double(coin.changePercent24Hr) ?? 0.0 < 0 {
            return UIColor.systemRed
        } else {
            return UIColor.systemGreen
        }
    }
}
