//
//  PlayersState.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 11.11.2020.
//

import Foundation

final class PlayersState: GameState {

    private var players = [Player]()
    private var curentPlayerIndex: Int = 0
    private let delegate: WithStateUpdatable
    
    var player: Player? {
        players[curentPlayerIndex]
    }
    
    convenience init(players: [Player], delegate: WithStateUpdatable) {
        self.init(delegate: delegate)
        self.players = players
    }
    
    required init(delegate: WithStateUpdatable) {
        self.delegate = delegate
    }
 
    func update() {
        if let player = player  {
            delegate.updateWithState(lableText: "Сейчас ходит: \(player.name)")
            setNextPlayer()
        }
    }
    
    private func setNextPlayer() {
        if (curentPlayerIndex + 1) < players.count {
            curentPlayerIndex += 1
        } else {
            curentPlayerIndex = 0
        }
    }
}
