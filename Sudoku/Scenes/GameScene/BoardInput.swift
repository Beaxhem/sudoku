//
//  BoardInput.swift
//  Sudoku
//
//  Created by Illia Senchukov on 03.01.2024.
//

import SpriteKit

protocol BoardInputDelegate: AnyObject {
    func setValue(_ value: Int)
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
            guard button.intersects(point: pos),
                  let value = Int(button.text) else {
                continue
            }
            delegate?.setValue(value)
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
