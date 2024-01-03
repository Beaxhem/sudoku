//
//  GameBoard.swift
//  Sudoku
//
//  Created by Illia Senchukov on 03.01.2024.
//

import SpriteKit

final class GameBoard {

    var frame: CGRect

    var bounds: CGRect

    weak var scene: SKScene!

    var tiles: [Tile] = []

    var selectedTile: Tile?

    var tileWidth: CGFloat {
        bounds.width / 9
    }

    init(gameRect: CGRect, scene: SKScene) {
        let paddingX: CGFloat = 100
        self.frame = gameRect
        let offsetX = gameRect.width / 2 - paddingX
        self.bounds = .init(x: -offsetX, y: 0, width: gameRect.width - paddingX * 2, height: gameRect.width - paddingX * 2)
        self.scene = scene

        setupBoard()
    }

    func didTouch(at pos: CGPoint) {
        guard let tile = tiles.tile(at: pos) else { return }

        selectedTile?.isSelected = false
        selectedTile = nil

        tile.isSelected = true
        selectedTile = tile
    }

}

private extension GameBoard {

    func setupBoard() {
        setupTiles()
        setupLines()
    }

    func setupTiles() {
        let tileWidth = self.tileWidth
        var tiles: [Tile] = []

        for y in stride(from: 0 as CGFloat, to: 9, by: 1) {
            for x in stride(from: 0 as CGFloat, to: 9, by: 1) {
                let tile = Tile(rect: .init(x: x * tileWidth + bounds.minX,
                                            y: y * tileWidth + bounds.minY,
                                            width: tileWidth,
                                            height: tileWidth))
                tile.addAsChild(to: scene)
                tiles.append(tile)
            }
        }
        self.tiles = tiles
    }

    func setupLines() {
        // Vertical lines
        for i in stride(from: 3 as CGFloat, to: 9, by: 3) {
            let line = Line(from: .init(x: tileWidth * i + bounds.minX, y: bounds.minY),
                            to: .init(x: tileWidth * i + bounds.minX, y: bounds.maxY))
            line.strokeColor = .label
            line.lineWidth = 3
            scene.addChild(line)
        }

        // Horizontal lines
        for i in stride(from: 3 as CGFloat, to: 9, by: 3) {
            let line = Line(from: .init(x: bounds.minX, y: tileWidth * i + bounds.minY),
                            to: .init(x: bounds.maxX, y: tileWidth * i + bounds.minY))
            line.strokeColor = .label
            line.lineWidth = 3
            scene.addChild(line)
        }
    }

}
