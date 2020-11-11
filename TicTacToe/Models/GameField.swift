//
//  GameField.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import UIKit


final class GameField: UICollectionView {
    
    // MARK: - Properties
    
    private var field: [[Figure?]]
    private let cellFrame: CGRect
    private(set) var size: Int
    
    // MARK: init
    
    init(size: Int, frame: CGRect, collectionViewLayout: UICollectionViewLayout) {
        self.field = (0 ..< size).map{ _ in (0 ..< size).map { _ in nil } }
        self.size = size
        
        let width = frame.width / CGFloat(size)
        let height = frame.width / CGFloat(size)
        
        cellFrame = CGRect(x: 0,
                           y: 0,
                           width: width,
                           height: height
        )
        

        super.init(frame: frame,
                   collectionViewLayout: collectionViewLayout
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func getFigure(for indexPath: IndexPath) -> Figure? {
        let row = indexPath.section
        let column = indexPath.row
        
        return field[row][column]
    }
    
    func getColumn(_ column: Int) -> [Figure?] {
        return field.reduce(into: []) { $0.append($1[column]) }
    }
    
    func getRow(_ row: Int) -> [Figure?] {
        return field[row]
    }
    
    func getDiagonals() -> ([Figure?], [Figure?]) {
        let leftDiag = Array(0 ..< size).reduce(into: []) { $0.append(field[$1][$1]) }
        let rightDiag = Array(0 ..< size).reduce(into: []) { $0.append(field[$1][(size - $1)]) }
        return (leftDiag, rightDiag)
    }
}

// MARK: - FigureDrawable

protocol FigureDrawable {
    func draw(strategy: DrawStrategy, at indexPath: IndexPath)
}

extension GameField: FigureDrawable {
    func draw(strategy: DrawStrategy, at indexPath: IndexPath) {
        let row = indexPath.section
        let column = indexPath.row
        
        if field[row][column] == nil {
            field[row][column] = strategy.drawFigure(frame: cellFrame)
        } 
    }
}

