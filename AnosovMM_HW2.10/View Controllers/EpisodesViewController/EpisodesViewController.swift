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
    private var episodes: Welcome?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        fetchAllEpisodes(for: URLS.rickAndMortyApi.rawValue)
        super.viewDidLoad()
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episodes?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath)
        
        return cell
    }
    
    
}

extension EpisodesViewController {
    
    //MARK: - Network
    
    func fetchAllEpisodes(for url: String) {
        
        AF.request(url, method: .get)
            .validate()
//            .responseJSON { dataResponse in
//                switch dataResponse.result  {
//
//                case .success(let value):
//                    guard let episodes = value as? [[String: Any]] else { return }
//                    for episode in episodes {
//                        let episode = Result(
//                            id: episodes["id"] as? Int ?? 0,
//                            name: <#T##String#>, status: <#T##String?#>, species: <#T##String?#>, type: <#T##String?#>, gender: <#T##String?#>, origin: <#T##Location#>, location: <#T##Location#>, image: <#T##String#>, air_date: <#T##String?#>, episode: <#T##[String]#>, characters: <#T##[String]?#>, url: <#T##String#>, created: <#T##String#>)
//                        print(value)
//
//                        case .failure(let error):
//                        print(error)
//                    }
//                }

            }
    }
