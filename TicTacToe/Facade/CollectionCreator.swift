//
//  CollectionCreator.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import UIKit

class CollectionCreator {
        
    func createCollectionViewController(for controller: GameViewController, with size: Int) -> UICollectionView {
        let frame = getCollectionFrame(in: controller.view)
        let collectionViewLayout = getCollectionViewLayout(in: controller.view, with: CGFloat(size))
        
        let collectionView = UICollectionView(frame: frame,
                                          collectionViewLayout: collectionViewLayout)
        
        setUp(collectionView, in: controller)
        return collectionView
    }
    
    private func getCollectionFrame(in view: UIView) -> CGRect {
        let x: CGFloat = 0
        let y: CGFloat = view.frame.midY - (view.frame.width / 2)
        let width = view.frame.width
        let height = view.frame.width
        
        return CGRect(x: x,
                      y: y,
                      width: width,
                      height: height
        )
    }
    
    private func getCollectionViewLayout(in view: UIView, with size: CGFloat) -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let width = view.frame.width / size
        let height = view.frame.width / size
        
        layout.itemSize = CGSize(width: width,
                                 height: height
        )
        
        return layout
    }
    
    private func setUp(_ collectionView: UICollectionView, in controller: GameViewController) {
        collectionView.delegate = controller
        collectionView.dataSource = controller
        
        collectionView.register(UINib(nibName: CollectionViewCell.nibName, bundle: nil),
                                forCellWithReuseIdentifier: CollectionViewCell.id
        )
    }

}
