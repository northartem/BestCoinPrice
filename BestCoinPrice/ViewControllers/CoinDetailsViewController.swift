//
//  ViewController.swift
//  BestCoinPrice
//
//  Created by Артём Латушкин on 01.07.2023.
//

import UIKit

final class CoinDetailsViewController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    var coin: Coin!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = coin.name
        nameLabel.text = "Название: \(coin.name)"
        priceLabel.text = "Цена: \(coin.currentPrice)"
    }
}

