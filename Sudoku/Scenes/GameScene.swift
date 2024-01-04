//
//  GameScene.swift
//  Sudoku
//
//  Created by Illia Senchukov on 03.01.2024.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var boardInput: BoardInput!

    var gameBoardView: GameBoardView!

    override func didMove(to view: SKView) {
        self.backgroundColor = .systemBackground
        let generator = SudokuGenerator()
        let puzzle = generator.generatePuzzle(numberOfClues: 30)

        gameBoardView = .init(frame: frame, scene: self, grid: puzzle)
        boardInput = .init(frame: frame,
                           y: gameBoardView.bounds.minY - 70,
                           scene: self)
        boardInput.delegate = gameBoardView
    }

    func touchDown(at pos: CGPoint) {
        gameBoardView?.didTouch(at: pos)
        boardInput?.didTouch(at: pos)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            touchDown(at: touch.location(in: self))
        }
    }

}
