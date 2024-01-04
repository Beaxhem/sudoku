//
//  GameBoardView.swift
//  Sudoku
//
//  Created by Illia Senchukov on 03.01.2024.
//

import SpriteKit

final class GameBoardView: View {

    var board: GameBoard!

    var selectedTile: Tile?

    var tileWidth: CGFloat {
        bounds.width / 9
    }

    init(frame: CGRect, scene: SKScene, grid: [[Int]]) {
        let paddingX: CGFloat = 100
        let offsetX = frame.width / 2 - paddingX
        super.init(bounds: .init(x: -offsetX,
                                 y: 0,
                                 width: frame.width - paddingX * 2,
                                 height: frame.width - paddingX * 2),
                   scene: scene)

        setupBoard(grid: grid)
    }

    func didTouch(at pos: CGPoint) {
        guard let tile = board.tile(at: pos) else { return }

        selectedTile?.isSelected = false
        selectedTile = nil

        tile.isSelected = true
        selectedTile = tile

        highlightTheSameTiles()
        board.checkIfError()
    }

}

extension GameBoardView: BoardInputDelegate {

    func setValue(_ value: Int) {
        if selectedTile?.value == value {
            selectedTile?.value = 0
        } else {
            selectedTile?.value = value
        }
        highlightTheSameTiles()
        board.checkIfError()
    }

}

private extension GameBoardView {

    func highlightTheSameTiles() {
        guard let selectedTile else { return }
        board.highlightAll(withValue: selectedTile.value)
    }

}

private extension GameBoardView {

    func setupBoard(grid: [[Int]]) {
        setupTiles(grid: grid)
        setupLines()
    }

    func setupTiles(grid: [[Int]]) {
        let tileWidth = self.tileWidth
        var tiles: [Tile] = []

        for y in stride(from: 0, to: 9, by: 1) {
            for x in stride(from: 0, to: 9, by: 1) {
                let tile = Tile(frame: .init(x: CGFloat(x) * tileWidth + bounds.minX,
                                             y: CGFloat(y) * tileWidth + bounds.minY,
                                             width: tileWidth,
                                             height: tileWidth),
                                scene: scene)
                tile.value = grid[y][x]
                tile.addAsChild(to: scene)
                tiles.append(tile)
            }
        }
        self.board = .init(tiles: tiles)
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
