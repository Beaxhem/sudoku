//
//  Tile.swift
//  Sudoku
//
//  Created by Illia Senchukov on 03.01.2024.
//

import SpriteKit

class TileNode: SKShapeNode {

    weak var tile: Tile?

}

class Tile {

    var tileNode: TileNode

    var isSelected: Bool = false {
        didSet {
            tileNode.fillColor = isSelected ? .blue.withAlphaComponent(0.15) : .clear
        }
    }

    init(rect: CGRect) {
        tileNode = TileNode(rect: rect)
        tileNode.lineWidth = 1
        tileNode.strokeColor = .label
        tileNode.tile = self
    }

}

extension Tile {

    func addAsChild(to scene: SKScene) {
        scene.addChild(tileNode)
    }

}

extension Tile {

    func intersects(point: CGPoint) -> Bool {
        tileNode.frame.contains(point)
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
