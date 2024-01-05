//
//  GameScene.swift
//  Sudoku
//
//  Created by Illia Senchukov on 03.01.2024.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var health = Constant.maxHealth

    var healthBar: HealthBarView!

    var boardInput: BoardInput!

    var gameBoardView: GameBoardView!

    var gameLost = false

    var gameMode: GameMode!

    override func didMove(to view: SKView) {
        self.backgroundColor = .systemBackground

        healthBar = .init(maxHealth: Constant.maxHealth, frame: frame, scene: self)

        let generator = SudokuGenerator()
        let puzzle = generator.generatePuzzle(numberOfClues: gameMode.rawValue)

        gameBoardView = .init(frame: frame, scene: self, grid: puzzle)
        gameBoardView.delegate = self

        boardInput = .init(frame: frame,
                           y: gameBoardView.bounds.minY - 70,
                           scene: self)
        boardInput.delegate = gameBoardView

        healthBar.setHealth(health)
    }

    func touchDown(at pos: CGPoint) {
        gameBoardView?.didTouch(at: pos)
        boardInput?.didTouch(at: pos)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !gameLost else { return }

        for touch in touches {
            touchDown(at: touch.location(in: self))
        }
    }

}

extension GameScene: GameBoardDelegate {

    func didMakeMistake() {
        health -= 1
        healthBar.setHealth(health)

        guard health == 0 else { return }
        gameLost = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            let scene = SKScene(fileNamed: "GameOverScene")!
            scene.scaleMode = .aspectFill
            let transition = SKTransition.fade(with: .white, duration: 1)
            self?.scene?.view?.presentScene(scene, transition: transition)
        }
    }

}

extension GameScene {

    enum Constant {
        static let maxHealth = 3
    }

}
