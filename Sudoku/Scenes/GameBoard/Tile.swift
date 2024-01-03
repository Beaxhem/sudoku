//
//  Tile.swift
//  Sudoku
//
//  Created by Illia Senchukov on 03.01.2024.
//

import SpriteKit

class Tile: View {

    var tileNode: SKShapeNode

    var labelNode: SKLabelNode

    var isSelected: Bool = false {
        didSet {
            tileNode.fillColor = isSelected ? .blue.withAlphaComponent(0.15) : .clear
        }
    }

    var text: String = "" {
        didSet {
            labelNode.text = text
            updateLabelPosition()
        }
    }

    init(frame: CGRect, scene: SKScene) {
        tileNode = SKShapeNode(rect: frame)
        tileNode.lineWidth = 1
        tileNode.strokeColor = .label

        labelNode = SKLabelNode(fontNamed: UIFont.boldSystemFont(ofSize: 17).fontName)
        labelNode.fontName = UIFont.boldSystemFont(ofSize: 17).fontName
        labelNode.fontSize = 40
        labelNode.fontColor = .label
        super.init(bounds: frame, scene: scene)

        updateLabelPosition()
    }

}

extension Tile {

    func addAsChild(to scene: SKScene) {
        scene.addChild(tileNode)
        scene.addChild(labelNode)
    }

}

extension Tile {

    func intersects(point: CGPoint) -> Bool {
        tileNode.frame.contains(point)
    }

}

private extension Tile {

    func updateLabelPosition() {
        labelNode.position = .init(x: bounds.minX + bounds.width / 2, y: bounds.minY + bounds.height / 2 - labelNode.frame.height / 2)
    }

}

extension [Tile] {

    func tile(at pos: CGPoint) -> Tile? {
        for tile in self {
            if tile.intersects(point: pos) {
                return tile
            }
        }
        return nil
    }

}