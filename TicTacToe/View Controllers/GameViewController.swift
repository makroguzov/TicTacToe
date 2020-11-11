//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import UIKit

class GameViewController: UIViewController {

    // MARK: Properties
    
    var state: GameState! {
        didSet {
            state.update()
        }
    }
    var fieldSize: Int = 3

    // MARK: - Private properties
        
    private var gameField: GameField!
    private var curentPlayerLable: UILabel = UILabel()
    
    // MARK: - Life sycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGameField()
        addCurentPlayerLable()
    }
    
    // MARK: Methods
    
    private func addGameField() {
        let gameFieldCreator = GameFieldCreator()
        
        gameField = gameFieldCreator.createCollectionViewController(for: self, with: fieldSize)
        view.addSubview(gameField)
    }
    
    private func addCurentPlayerLable() {
        let constraints: [NSLayoutConstraint] = [
            curentPlayerLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            curentPlayerLable.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ]
        
        curentPlayerLable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(curentPlayerLable)
        view.addConstraints(constraints)
    }
}


// MARK: - WithStateUpdatable

protocol WithStateUpdatable {
    func updateWithState(playerName: String)
}

extension GameViewController: WithStateUpdatable {
    func updateWithState(playerName: String) {
        curentPlayerLable.text = "Сейчас ходит: \(playerName)"
        curentPlayerLable.sizeToFit()
    }
}


// MARK: - UICollectionViewDelegate

extension GameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let currentPlayer = state.player {
            currentPlayer.draw(inField: gameField, at: indexPath)
            collectionView.reloadItems(at: [indexPath])
            state.update()
        }
    }
}


// MARK: - UICollectionViewDataSource

extension GameViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fieldSize
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fieldSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let figure = gameField?.getFigure(for: indexPath) {
            return getFigureCell(with: figure, at: indexPath)
        } else {
            return getEmptyCell(at: indexPath)
        }
    }
    
    private func getEmptyCell(at indexPath: IndexPath) -> EmptyCollectionViewCell {
        guard let cell = gameField.dequeueReusableCell(withReuseIdentifier: EmptyCollectionViewCell.id,
                                                            for: indexPath) as? EmptyCollectionViewCell else {
            fatalError()
        }

        return cell
    }
    
    private func getFigureCell(with figure: Figure, at indexPath: IndexPath) -> FigureCollectionViewCell {
        guard let cell = gameField.dequeueReusableCell(withReuseIdentifier: FigureCollectionViewCell.id,
                                                            for: indexPath) as? FigureCollectionViewCell else {
            fatalError()
        }
        
        cell.setUp(with: figure)
        return cell
    }
}
