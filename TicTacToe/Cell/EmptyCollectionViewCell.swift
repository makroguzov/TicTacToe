//
//  EmptyCollectionViewCell.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import UIKit

class EmptyCollectionViewCell: UICollectionViewCell {

    static let id = "EmptyCollectionViewCell"
    static let nibName = "EmptyCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.borderWidth = 3
        layer.borderColor = UIColor.red.cgColor
    }

}
