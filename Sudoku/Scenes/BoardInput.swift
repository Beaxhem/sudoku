//
//  BoardInput.swift
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

protocol BoardInputDelegate: AnyObject {
    func setInput(_ text: String)
}

class BoardInput: View {

    var buttons: [Button]!

    weak var delegate: BoardInputDelegate?

    init(frame: CGRect, y: CGFloat, scene: SKScene!) {
        let paddingX: CGFloat = 100
        let height: CGFloat = 75
        let offsetX = frame.width / 2 - paddingX
        super.init(bounds: .init(x: -offsetX,
                                 y: y - height,
                                 width: frame.width - paddingX * 2,
                                 height: height),
                   scene: scene)

        setupButtons()
    }

}

extension BoardInput {

    func didTouch(at pos: CGPoint) {
        for button in buttons {
            guard button.intersects(point: pos) else { continue }
            delegate?.setInput(button.text)
            return
        }
    }

}

private extension BoardInput {

    func setupButtons() {
        let n: CGFloat = 9
        let spacing: CGFloat = 10
        let width = (bounds.width - (n - 1) * spacing) / n
        var buttons: [Button] = []

        for i in stride(from: 0 as CGFloat, to: n, by: 1) {
            let button = Button(frame: .init(x: i * width + bounds.minX + spacing * i, y: bounds.minY, width: width, height: width),
                                text: "\(Int(i + 1))",
                                scene: scene)
            button.addAsChild(to: scene)
            buttons.append(button)
        }
        self.buttons = buttons
    }

}
