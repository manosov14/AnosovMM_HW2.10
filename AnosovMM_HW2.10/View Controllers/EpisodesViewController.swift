//
//  EpisodesViewController.swift
//  AnosovMM_HW2.10
//
//  Created by Михаил on 12.08.2021.
//

import UIKit

class EpisodesViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath)
        
        return cell
    }
    

}

extension EpisodesViewController {
    //MARK: - Network
    
    func fetchAllEpisodes(for url: String) {
        NetworkManager.shared.fetchAllEpisodes(for: url) {_ in

        }
    }
}
