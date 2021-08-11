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
    @IBOutlet weak var characterInfoOU: UILabel!

    //MARK: - Properties
    private var currentPage = 1
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        characterImageOU.layer.cornerRadius = self.characterImageOU.frame.height / 2
    }
}

//MARK: - Network
extension ProfileViewController {
    
    func fetchCharacterInfo(from url: String?, with characterId: Int?) {
        NetworkManager.shared.fetchCharacterInfo(from: url, characterId: characterId) {
            characterData in
            print(characterData)
            guard let image = ImageManager.shared.fetchImage(from: characterData.image) else { return }
            DispatchQueue.main.async {
                self.characterImageOU.image = UIImage(data: image)
                self.characterImageOU.layer.cornerRadius = self.characterImageOU.frame.height / 2
                self.characterNameOU.text = characterData.name
                self.characterInfoOU.text = characterData.discription
            }
            self.characterImageOU.layer.cornerRadius = self.characterImageOU.frame.height / 2
            self.characterNameOU.text = characterData.name
            self.characterInfoOU.text = characterData.discription
        }
    }    
}

