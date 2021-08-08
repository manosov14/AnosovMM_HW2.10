//
//  PersonListCollectionViewController.swift
//  AnosovMM_HW2.10
//
//  Created by Михаил on 07.08.2021.
//

import UIKit

enum UserActions: String, CaseIterable {
    case characters = "Characters"
    case episodes = "Episodes"
}

class MainViewController: UICollectionViewController {
    // MARK: - public properties
    let userActions = UserActions.allCases
    
    
    // MARK: - Navigations
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCharacters" {
            guard let characterVC = segue.destination as? CharacterViewController else {return}
            characterVC.fetchCharacters()
        }
    }
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! MainMenuCell
        //        cell.backgroundColor = .lightGray
        cell.categoryLabelOU.text = userActions[indexPath.item].rawValue
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .characters:
            performSegue(withIdentifier: "showCharacters", sender: nil)
        case .episodes:
            performSegue(withIdentifier: "showEpisodes", sender: nil)
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
}
