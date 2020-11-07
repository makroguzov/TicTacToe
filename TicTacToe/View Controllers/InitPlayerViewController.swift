//
//  InitPlayerViewController.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import UIKit

class InitPlayerViewController: UIViewController {

    private enum Errors: Error {
        case NoPlayerName
        case NoStrategySelected
    }
    
    @IBOutlet private weak var playerLable: UILabel!
    @IBOutlet private weak var playerNameTextField: UITextField! {
        didSet {
            playerNameTextField.delegate = self
        }
    }
    @IBOutlet private weak var figureSegmentControl: UISegmentedControl!
    @IBOutlet weak var createPlayerButton: UIButton!
    
    private let playersCount = 2
    private var players = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    @IBAction func createPlayerButtonAction(_ sender: UIButton) {
        if (players.count + 1) == playersCount {
            startTheGame()
        } else {
            createPlayer()
        }
    }
    
    private func createPlayer() {
        do {
            let name = try getName()
            let strategy = try getStrategy()
            
            let player = Player(name: name,
                                drawStrategy: strategy
            )
            players.append(player)
            
            updateUI()
        } catch Errors.NoPlayerName {
            showAllert(title: "", message: "Не задано имя пользователя.")
        } catch Errors.NoStrategySelected {
            showAllert(title: "", message: "Не выбрана стратегия.")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func getName() throws -> String {
        guard let name = playerNameTextField.text else {
            throw Errors.NoPlayerName
        }
        return name
    }
    
    private func getStrategy() throws -> DrawStrategy {
        let factory = DrawStrategysFactory()
        let selectedItem = figureSegmentControl.selectedSegmentIndex
        
        let strategy: DrawStrategy
        switch selectedItem {
        case 0:
            strategy = factory.getStrategy(figure: .cross)
        case 1:
            strategy = factory.getStrategy(figure: .zero)
        default:
            throw Errors.NoStrategySelected
        }
        
        figureSegmentControl.removeSegment(at: selectedItem, animated: true)
        return strategy
    }
    
    private func updateUI() {
        playerLable.text = "Set up Player \(players.count + 1)"
        playerNameTextField.text = ""
        figureSegmentControl.selectedSegmentIndex = 0
    }
    
    private func showAllert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert
        )
        present(alert, animated: true, completion: nil)
    }
    
    private func startTheGame() {
        performSegue(withIdentifier: "StartTheGame", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let id = segue.identifier
        switch id {
        case "StartTheGame":
            guard let destionation = segue.destination as? GameViewController else {
                fatalError()
            }
            
            destionation.players = players
        default:
            return
        }
    }
}

extension InitPlayerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
