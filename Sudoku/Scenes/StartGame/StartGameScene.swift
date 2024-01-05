//
//  StartGameScene.swift
//  Sudoku
//
//  Created by Illia Senchukov on 05.01.2024.
//

import SpriteKit

class StartGameScene: SKScene {

    var easyButton: Button!
    var mediumButton: Button!
    var hardButton: Button!

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = .white
        let spacingX: CGFloat = 100

        easyButton = Button(frame: .init(x: view.frame.width / -2 + spacingX,
                                         y: 100,
                                         width: view.frame.width - spacingX * 2,
                                         height: 75),
                            text: "Easy",
                            scene: self)
        mediumButton = Button(frame: .init(x: view.frame.width / -2 + spacingX,
                                           y: 0,
                                           width: view.frame.width - spacingX * 2,
                                           height: 75),
                              text: "Medium",
                              scene: self)
        hardButton = Button(frame: .init(x: view.frame.width / -2 + spacingX,
                                         y: -100,
                                         width: view.frame.width - spacingX * 2,
                                         height: 75),
                            text: "Hard",
                            scene: self)

        for button in [easyButton, mediumButton, hardButton] {
            button?.backgroundNode.fillColor = .systemBlue.withAlphaComponent(0.05)
            button?.cornerRadius = 15
            button?.addAsChild(to: self)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let pos = touch.location(in: self)
            if easyButton.intersects(point: pos) {
                return startGame(mode: .easy)
            }
            if mediumButton.intersects(point: pos) {
                return startGame(mode: .medium)
            }
            if hardButton.intersects(point: pos) {
                return startGame(mode: .hard)
            }
        }
    }

}

private extension StartGameScene {

    func startGame(mode: GameMode) {
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else { return }
        let transition = SKTransition.fade(withDuration: 1)
        scene.gameMode = mode
        scene.scaleMode = .aspectFill
        view?.presentScene(scene, transition: transition)
    }

}

enum GameMode: Int {
    case easy = 25
    case medium = 34
    case hard = 40
}
