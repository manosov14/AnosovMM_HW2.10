//
//  ProfileViewController.swift
//  AnosovMM_HW2.10
//
//  Created by Михаил on 08.08.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var characterImageOU: UIImageView!
    @IBOutlet weak var characterNameOU: UILabel!
    @IBOutlet weak var characterStatusOU: UILabel!
    @IBOutlet weak var aboutCharacterOU: UILabel!
    
    @IBOutlet weak var characterBirthPlaceOU: UILabel!
    var charaterId: Int?
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacterInfo(with: character)
    }
    
    // MARK: - Navigation
}

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
                self.successAlert()
                print(self.character)
                
            } catch let error {
                self.errorAlert()
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
//            self.characterBirthPlaceOU.text = self.character.origin.name
        }
    }
}
