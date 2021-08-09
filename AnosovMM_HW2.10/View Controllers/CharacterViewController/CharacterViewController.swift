//
//  CharacterTableViewController.swift
//  AnosovMM_HW2.10
//
//  Created by Михаил on 07.08.2021.
//

import UIKit

class CharacterViewController: UITableViewController {

    //MARK: Private Properties
    
    private var characters: Welcome = Welcome.init(info: nil, results: nil)
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacters()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.results?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell") as! CharacterCell
        let character = characters.results?[indexPath.row]
        cell.configure(with: character!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRowIndex = characters.results?[indexPath.row].id
        performSegue(withIdentifier: "profileCharacter", sender: selectedRowIndex)
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileCharacter" {
            guard let profileVC = segue.destination as? ProfileViewController else { return }
            profileVC.charaterId = sender as? Int ?? 10
            profileVC.fetchCurrentCharacterData()
        }
    }
}

// MARK: - Network

extension CharacterViewController {
    
    func fetchCharacters() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let response = response { print(response)}
            guard let data = data else {
                print(error?.localizedDescription ?? "No description message")
                print(data ?? "no data")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                self.characters = try decoder.decode(Welcome.self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    print(self.characters)
                }
            } catch let error {
                print(error)
            }
        }.resume()
        return
    }
    
    private func successAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Success", message: "Your request is done", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            self.present(alert, animated: true)
            alert.addAction(okAction)
        }
    }
    
    private func errorAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "Your request is failed", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            self.present(alert, animated: true)
            alert.addAction(okAction)
        }
        
    }
}
