//
//  CoinTableViewCell.swift
//  BestCoinPrice
//
//  Created by Артём Латушкин on 01.07.2023.
//

import UIKit

class CoinTableViewCell: UITableViewCell {

    @IBOutlet var logoImage: UIImageView! {
        didSet {
            logoImage.layer.cornerRadius = logoImage.frame.height / 2
        }
    }
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var changeLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    func configure(with coin: Coin) {
        nameLabel.text = coin.name
        changeLabel.text = "\(String(format: "%.2f", coin.marketCapChangePercentage24H))%"
        priceLabel.text = String(format: "%.2f", coin.currentPrice)
        
        DispatchQueue.global().async { [weak self] in
            guard let imageData = try? Data(contentsOf: coin.image) else { return }
            DispatchQueue.main.async {
                self?.logoImage.image = UIImage(data: imageData)
            }
        }
        
        let color = changePrice(with: coin)
        changeLabel.textColor = color
    }
}

extension CoinTableViewCell {
    private func changePrice(with coin: Coin) -> UIColor {
        if coin.marketCapChange24H < 0 {
            return UIColor.systemRed
        } else {
            return UIColor.systemGreen
        }
    }
}
