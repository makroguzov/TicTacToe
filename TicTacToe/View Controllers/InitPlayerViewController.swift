//
//  InitPlayerViewController.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import UIKit

class InitPlayerViewController: UIViewController {

    // MARK: - Errors description
    
    private enum Errors: Error {
        case NoPlayerName
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var playerLable: UILabel!
    @IBOutlet private weak var playerNameTextField: UITextField! {
        didSet {
            playerNameTextField.delegate = self
        }
    }
    @IBOutlet private weak var figureSegmentControl: UISegmentedControl!
    @IBOutlet private weak var createPlayerButton: UIButton!
    
    // MARK: - Properties
    
    private let playersCount = 2
    private var players = [Player]()
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    // MARK: - IBActions
    
    @IBAction func createPlayerButtonAction(_ sender: UIButton) {
        if players.count < playersCount {
            createPlayer()
        } else {
            startTheGame()
        }
    }
    
    // MARK: - Methods
    
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
        } catch DrawStrategysFactory.Errors.InvalidFigureId {
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
        
        do {
            let strategy: DrawStrategy
            strategy = try factory.getStrategy(figureId: selectedItem)
            figureSegmentControl.removeSegment(at: selectedItem, animated: true)
            return strategy
        } catch {
            throw error
        }
    }
    
    private func showAllert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert
        )
        present(alert, animated: true, completion: nil)
    }

    // MARK: - UI Methods
    
    private func updateUI() {
        if players.count == playersCount {
            playerLable.isHidden = true
            figureSegmentControl.isHidden = true
            playerNameTextField.isHidden = true
            createPlayerButton.setTitle("Start the game", for: .normal)
        } else {
            playerLable.text = "Set up Player \(players.count + 1)"
            playerNameTextField.text = ""
            figureSegmentControl.selectedSegmentIndex = 0
        }
    }
    
    
    // MARK: - Start The Game methods
    
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
            
            let state = PlayersState(players: players, delegate: destionation)
            
            destionation.fieldSize = 3
            destionation.state = state
        default:
            return
        }
    }
}

// MARK: - UITextFieldDelegate

extension InitPlayerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
