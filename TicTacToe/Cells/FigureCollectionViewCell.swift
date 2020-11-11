//
//  CollectionViewCell.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import UIKit

final class FigureCollectionViewCell: UICollectionViewCell {

    static let id = "FigureCollectionViewCell"
    static let nibName = "FigureCollectionViewCell"
    
    @IBOutlet private weak var figure: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 3
        layer.borderColor = UIColor.red.cgColor
    }

    func setUp(with figure: Figure) {
        self.figure = figure
        figure.bounds = bounds
    }
}
