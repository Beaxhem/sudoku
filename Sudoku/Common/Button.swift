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

    var cornerRadius: CGFloat = 0 {
        didSet {
            let path = CGPath(roundedRect: bounds,
                              cornerWidth: cornerRadius,
                              cornerHeight: cornerRadius,
                              transform: nil)
            backgroundNode.path = path
        }
    }

    init(frame: CGRect, text: String, scene: SKScene) {
        backgroundNode = SKShapeNode(rect: frame)
        labelNode = SKLabelNode(fontNamed: UIFont.boldSystemFont(ofSize: 17).fontName)
        labelNode.text = text
        labelNode.fontName = Constant.font.fontName
        labelNode.fontSize = Constant.font.pointSize
        labelNode.fontColor = .systemBlue
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
        labelNode.position = .init(x: bounds.minX + bounds.width / 2,
                                   y: bounds.minY + bounds.height / 2 - (bounds.height - labelNode.frame.height) / 2)
    }

}

private extension Button {

    enum Constant {
        static let font = UIFont.systemFont(ofSize: 40, weight: .bold).rounded
    }

}
