//
//  GameOverScene.swift
//  Sudoku
//
//  Created by Illia Senchukov on 05.01.2024.
//

import SpriteKit

class GameOverScene: SKScene {

    var tryAgainButton: Button!

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = .white

        let spacingX: CGFloat = 100
        tryAgainButton = Button(frame: .init(x: view.frame.width / -2 + spacingX,
                                             y: -100,
                                         width: view.frame.width - spacingX * 2,
                                         height: 75),
                            text: "Try again",
                            scene: self)
        tryAgainButton.addAsChild(to: self)
        tryAgainButton.backgroundNode.fillColor = .systemBlue.withAlphaComponent(0.15)
        tryAgainButton.cornerRadius = 15
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            guard tryAgainButton.intersects(point: touch.location(in: self)) else { continue }

            let transition = SKTransition.crossFade(withDuration: 1)
            let scene = SKScene(fileNamed: "StartGameScene")!
            scene.scaleMode = .aspectFill
            view?.presentScene(scene, transition: transition)
            return
        }
    }

}
