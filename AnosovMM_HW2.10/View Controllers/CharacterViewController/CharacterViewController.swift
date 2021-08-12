//
//  CharacterTableViewController.swift
//  AnosovMM_HW2.10
//
//  Created by Михаил on 07.08.2021.
//

import UIKit

class CharacterViewController: UITableViewController {

    //MARK: Private Properties
    private var characters: Welcome?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell") as! CharacterCell
        let character = characters?.results[indexPath.row]
        cell.configure(with: character)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let selectedRowIndex = characters?.results[indexPath.row].id
        performSegue(withIdentifier: "profileCharacter", sender: selectedRowIndex)
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileCharacter" {
            guard let profileVC = segue.destination as? ProfileViewController else { return }
            let characterId = sender as? Int ?? 0
            profileVC.fetchCharacterInfo(from: URLS.rickAndMortyApi.rawValue, with: characterId)
        }
    }
    
    // MARK: - Network
    func fetchAllCharacters(from url: String) {
        NetworkManager.shared.fetchData(from: url) {
            rickAndMorty in
            self.characters = rickAndMorty
            self.tableView.reloadData()
        }
    }
}
