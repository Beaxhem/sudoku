//
//  GameScene.swift
//  Sudoku
//
//  Created by Illia Senchukov on 03.01.2024.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var gameBoard: GameBoard!

    override func didMove(to view: SKView) {
        self.backgroundColor = .systemBackground
        gameBoard = .init(gameRect: frame, scene: self)
    }

    func touchDown(at pos: CGPoint) {
        gameBoard?.didTouch(at: pos)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            touchDown(at: touch.location(in: self))
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }

}
