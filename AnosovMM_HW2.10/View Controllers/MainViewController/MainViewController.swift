//
//  PersonListCollectionViewController.swift
//  AnosovMM_HW2.10
//
//  Created by Михаил on 07.08.2021.
//

import UIKit

enum UserActions: String, CaseIterable {
    case characters = "Characters"
}

class MainViewController: UICollectionViewController {
    // MARK: - Public properties
    
    let userActions = UserActions.allCases
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! MainMenuCell
        cell.categoryLabelOU.text = userActions[indexPath.item].rawValue
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .characters:
            performSegue(withIdentifier: "showCharacters", sender: nil)
        }
    }
    
    // MARK: - Navigations
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCharacters" {
            guard let characterVC = segue.destination as? CharacterViewController else {return}
            characterVC.fetchAllCharacters(from: URLS.rickAndMortyApi.rawValue)
        }
    }
}

//MARK: - Extensions

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
}
