//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import UIKit

class GameViewController: UIViewController {

    private var collectionView: UICollectionView!
    private var currentPlayer: Player?
    private var nextPlayer: Player {
        guard let currentPlayer = currentPlayer else {
            return players[0]
        }
        
        guard let ind = players.firstIndex(where: { $0 === currentPlayer }) else {
            fatalError()
        }
        
        if ind == players.count - 1 {
            return players[0]
        } else {
            return players[ind + 1]
        }
    }
    
    
    private let collectionCreator = CollectionCreator()
    
    var players = [Player]()
    var fieldSize: Int = 3

    override func viewDidLoad() {
        super.viewDidLoad()

        currentPlayer = nextPlayer
        addCollectionView()
    }
    
    private func addCollectionView() {
        collectionView = collectionCreator.createCollectionViewController(for: self, with: fieldSize)
        view.addSubview(collectionView)
    }
}

extension GameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension GameViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fieldSize
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fieldSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.id,
                                                            for: indexPath) as? CollectionViewCell else {
            fatalError()
        }
                
        guard let figure = currentPlayer?.draw() else {
            return UICollectionViewCell()
        }
        
        cell.setUp(with: figure)
        return cell
    }
}
