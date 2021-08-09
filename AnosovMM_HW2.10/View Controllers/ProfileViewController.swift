//
//  ProfileViewController.swift
//  AnosovMM_HW2.10
//
//  Created by Михаил on 08.08.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var characterImageOU: UIImageView!
    @IBOutlet weak var characterNameOU: UILabel!
    @IBOutlet weak var characterStatusOU: UILabel!
    @IBOutlet weak var aboutCharacterOU: UILabel!
    
    @IBOutlet weak var characterBirthPlaceOU: UILabel!
    
    //MARK: - Public properties
    
    var charaterId: Int?
    
    //MARK: - Private properties
    
    private var character: characterResult = characterResult.init(
        id: 0,
        name: "",
        status: "",
        species: "",
        type: "",
        gender: "",
        origin: Location.init(
            name: "",
            url: ""),
        location: Location.init(
            name: "",
            url: ""),
        image: "",
        episode: [""],
        url: "",
        created: "")
    
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacterInfo(with: character)
    }
}

//MARK: - Network
extension ProfileViewController {
    
    func fetchCurrentCharacterData() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/\(charaterId ?? 0)") else {
            return
        }
        print(url)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let response = response { print(response)}
            
            guard let data = data else {
                print(error?.localizedDescription ?? "No description message")
                print(data ?? "no data")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                self.character = try decoder.decode(characterResult.self, from: data)
                print(self.character)
                
            } catch let error {
                print(error)
            }
        }.resume()
        return
    }
    
    func fetchCharacterInfo(with character: characterResult) {
        guard let url = URL(string: character.image ) else {return}
        guard let imageData = try? Data(contentsOf: url) else { return }
        
        DispatchQueue.main.async {
            let aboutCharacter = "\(self.character.species), \(self.character.gender)"
            
            self.characterImageOU.image = UIImage(data: imageData)
            self.characterImageOU.layer.cornerRadius = self.characterImageOU.frame.height / 2
            self.characterNameOU.text = self.character.name
            self.characterStatusOU.text = self.character.status
            self.aboutCharacterOU.text = aboutCharacter
            self.characterBirthPlaceOU.text = "Planet:  \(self.character.origin.name ?? "Planet is not identify")"
        }
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
