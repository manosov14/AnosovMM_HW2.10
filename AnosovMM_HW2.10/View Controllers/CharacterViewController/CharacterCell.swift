//
//  CharacterCell.swift
//  AnosovMM_HW2.10
//
//  Created by Михаил on 07.08.2021.
//

import UIKit

class CharacterCell: UITableViewCell {

    @IBOutlet weak var characterImageOU: UIImageView!
    @IBOutlet weak var characterNameOU: UILabel!
    @IBOutlet weak var charcterSpeciesOU: UILabel!
    @IBOutlet weak var characterGenderOU: UILabel!
    
    func configure(with character: Result) {
        characterNameOU.text = character.name
        charcterSpeciesOU.text = character.species?.rawValue
        characterGenderOU.text = character.gender?.rawValue
        
        guard let url = URL(string: character.image ?? "") else { return }
        guard let imageData = try? Data(contentsOf: url) else { return }
        
        DispatchQueue.main.async {
            self.characterImageOU.image = UIImage(data: imageData)
            self.characterImageOU.layer.cornerRadius = self.characterImageOU.frame.width/2
        }
    }

    

    
    
}
