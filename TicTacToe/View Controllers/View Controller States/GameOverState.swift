//
//  GameOverState.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 11.11.2020.
//

import Foundation

final class GameOverState: GameState {
    
    var player: Player?
    
    private var delegate: WithStateUpdatable
    
    func update() {
        if let winner = player {
            delegate.updateWithState(lableText: "Player: \(winner.name) win.")
        } else {
            delegate.updateWithState(lableText: "No winner.")
        }
    }
    
    required init(delegate: WithStateUpdatable) {
        self.delegate = delegate
    }
}
