//
//  CoinListViewController.swift
//  BestCoinPrice
//
//  Created by Артём Латушкин on 01.07.2023.
//

import UIKit

final class CoinListTableViewController: UITableViewController {
    
    private var coins: [Coin] = []
    private let networkManager = NetworkManager.shares

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Coin List"
        fetchCharacter()
    }    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        guard let cell = cell as? CoinTableViewCell else { return UITableViewCell() }
        let coin = coins[indexPath.row]
        
        cell.configure(with: coin)

        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let coinDetailsVC = segue.destination as? CoinDetailsViewController
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        coinDetailsVC?.coin = coins[indexPath.row]
    }
}

// MARK: - Networking
extension CoinListTableViewController {
    
    private func fetchCharacter() {
        networkManager.fetchCharacter(from: Link.coinListLink.url) { result in
            switch result {
            case .success(let coin):
                self.coins = coin.data
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
