//
//  CollectionViewCell.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    static let id = "CollectionViewCell"
    static let nibName = "CollectionViewCell"
    
    @IBOutlet private weak var figure: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 3
        layer.borderColor = UIColor.red.cgColor
    }

    func setUp(with figure: Figure) {
        self.figure = figure
    }
}
