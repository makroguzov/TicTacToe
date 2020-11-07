//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import UIKit

class GameViewController: UIViewController {

    private var collectionView: UICollectionView!
    private var currentPlayer: Player?
    private var nextPlayer: Player {
        guard let currentPlayer = currentPlayer else {
            return players[0]
        }
        
        guard let ind = players.firstIndex(where: { $0 === currentPlayer }) else {
            fatalError()
        }
        
        if ind == players.count - 1 {
            return players[0]
        } else {
            return players[ind + 1]
        }
    }
    var players = [Player]()
    var fieldSize: Int = 3

    override func viewDidLoad() {
        super.viewDidLoad()

        currentPlayer = nextPlayer
        
        addColectionView()
        setUpColectionView()
    }
    
    private func addColectionView() {
        let frame = getCollectionFrame()
        let collectionViewLayout = getCollectionViewLayout()
        
        collectionView = UICollectionView(frame: frame,
                                          collectionViewLayout: collectionViewLayout)
        
        view.addSubview(collectionView)
    }
    
    private func getCollectionFrame() -> CGRect {
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
    
    private func getCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let width = view.frame.width / CGFloat(fieldSize)
        let height = view.frame.width / CGFloat(fieldSize)
        
        layout.itemSize = CGSize(width: width,
                                 height: height
        )
        
        return layout
    }
    
    private func setUpColectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: CollectionViewCell.nibName, bundle: nil),
                                forCellWithReuseIdentifier: CollectionViewCell.id
        )
    }
}

extension GameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension GameViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fieldSize
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fieldSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.id,
                                                            for: indexPath) as? CollectionViewCell else {
            fatalError()
        }
                
        guard let figure = currentPlayer?.draw() else {
            return UICollectionViewCell()
        }
        
        cell.setUp(with: figure)
        return cell
    }
}
