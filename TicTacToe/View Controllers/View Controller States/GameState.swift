//
//  GameState.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 11.11.2020.
//

import Foundation

protocol GameState {
    
    var player: Player? { get }
    func update()
    
    init(delegate: WithStateUpdatable) 
    
}
