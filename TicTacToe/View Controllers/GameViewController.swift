//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import UIKit

final class GameViewController: UIViewController {

    // MARK: Properties
    
    var state: GameState! {
        didSet {
            state.update()
        }
    }
    var fieldSize: Int = 3

    // MARK: - Private properties
        
    private var gameField: GameField!
    private var checker: WinnerChecker!
    
    private var moveCounter: Int = 0

    private var curentPlayerLable: UILabel = UILabel()
    
    // MARK: - Life sycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGameField()
        addWinnerChecker()
        addCurentPlayerLable()
    }
    
    // MARK: Methods
    
    private func addGameField() {
        let gameFieldCreator = GameFieldCreator()
        
        gameField = gameFieldCreator.createCollectionViewController(for: self, with: fieldSize)
        view.addSubview(gameField)
    }
    
    private func addWinnerChecker() {
        checker = WinnerChecker(gameField: gameField)
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
    func updateWithState(lableText: String)
}

extension GameViewController: WithStateUpdatable {
    func updateWithState(lableText: String) {
        curentPlayerLable.text = lableText
        curentPlayerLable.sizeToFit()
    }
}


// MARK: - UICollectionViewDelegate

extension GameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let currentPlayer = state.player {
            makeMove(with: currentPlayer, at: indexPath)
            
            collectionView.reloadItems(at: [indexPath])
            state.update()
        }
    }
    
    private func makeMove(with player: Player, at indexPath: IndexPath) {
        player.draw(inField: gameField, at: indexPath)
        moveCounter += 1
        
        if let winner = defineWinner(lastMove: indexPath, player: player) {
            state = GameOverState(delegate: self, winner: winner)
        } else if moveCounter == (fieldSize * fieldSize) {
            state = GameOverState(delegate: self, winner: nil)
        }
    }
    
    private func defineWinner(lastMove: IndexPath, player: Player) -> Player? {
        if checker.isPlayerWin(lastMove: lastMove, player: player) {
            return player
        } else {
            return nil
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
