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
    
    private var field: GameField?
    
    var players = [Player]()
    var fieldSize: Int = 3

    override func viewDidLoad() {
        super.viewDidLoad()

        field = GameField(size: fieldSize)
        
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
        if let field = field {
            currentPlayer?.draw(in: field, at: indexPath)
            collectionView.reloadItems(at: [indexPath])
        }
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
        if let figure = field?.getFigure(for: indexPath) {
            return getFigureCell(with: figure, at: indexPath)
        } else {
            return getEmptyCell(at: indexPath)
        }
    }
    
    private func getEmptyCell(at indexPath: IndexPath) -> EmptyCollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCollectionViewCell.id,
                                                            for: indexPath) as? EmptyCollectionViewCell else {
            fatalError()
        }

        return cell
    }
    
    private func getFigureCell(with figure: Figure, at indexPath: IndexPath) -> FigureCollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FigureCollectionViewCell.id,
                                                            for: indexPath) as? FigureCollectionViewCell else {
            fatalError()
        }
        
        figure.draw(cell.bounds)
        cell.setUp(with: figure)
        return cell
    }
}
