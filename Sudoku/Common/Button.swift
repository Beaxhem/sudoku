//
//  Button.swift
//  Sudoku
//
//  Created by Illia Senchukov on 03.01.2024.
//

import SpriteKit

class Button: View {

    var backgroundNode: SKShapeNode!

    var labelNode: SKLabelNode!

    var text: String {
        didSet {
            labelNode.text = text
        }
    }

    init(frame: CGRect, text: String, scene: SKScene) {
        backgroundNode = SKShapeNode(rect: frame)
        backgroundNode.fillColor = .gray
        labelNode = SKLabelNode(fontNamed: UIFont.boldSystemFont(ofSize: 17).fontName)
        labelNode.text = text
        labelNode.fontName = UIFont.boldSystemFont(ofSize: 17).fontName
        labelNode.fontSize = 40
        self.text = text
        super.init(bounds: frame, scene: scene)

        updateLabelPosition()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addAsChild(to scene: SKScene) {
        scene.addChild(backgroundNode)
        scene.addChild(labelNode)
    }

    func intersects(point: CGPoint) -> Bool {
        backgroundNode.frame.contains(point)
    }

}

private extension Button {

    func updateLabelPosition() {
        labelNode.position = .init(x: bounds.minX + bounds.width / 2, y: bounds.minY + bounds.height / 2 - labelNode.frame.height / 2)
    }

}
