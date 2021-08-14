//
//  EpisodesViewController.swift
//  AnosovMM_HW2.10
//
//  Created by Михаил on 12.08.2021.
//

import UIKit
import Alamofire


class EpisodesViewController: UITableViewController {
    // MARK: - Properties
    private var results: [Result] = []
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAllEpisodes(for: URLS.rickAndMortyApi.rawValue)

    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        let result = results[indexPath.row]
        content.text = result.name
        cell.contentConfiguration = content
        
        return cell
    }
}

extension EpisodesViewController {
    
    //MARK: - Network
    
    func fetchAllEpisodes(for url: String) {
        NetworkManager.shared.fetchAllEpisodes() {
            episodes in
            self.results = episodes
            print(self.results)
            self.tableView.reloadData()
        }
    }
}

