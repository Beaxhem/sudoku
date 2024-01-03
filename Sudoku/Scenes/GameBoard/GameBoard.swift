//
//  GameBoard.swift
//  Sudoku
//
//  Created by Illia Senchukov on 03.01.2024.
//

import SpriteKit

final class GameBoard: View {

    var tiles: [Tile] = []

    var selectedTile: Tile?

    var tileWidth: CGFloat {
        bounds.width / 9
    }

    init(frame: CGRect, scene: SKScene) {
        let paddingX: CGFloat = 100
        let offsetX = frame.width / 2 - paddingX
        super.init(bounds: .init(x: -offsetX,
                                 y: 0,
                                 width: frame.width - paddingX * 2,
                                 height: frame.width - paddingX * 2),
                   scene: scene)

        setupBoard()
    }

    func didTouch(at pos: CGPoint) {
        guard let tile = tiles.tile(at: pos) else { return }

        selectedTile?.isSelected = false
        selectedTile = nil

        tile.isSelected = true
        selectedTile = tile

        highlightTheSameTiles()
        checkIfError()
    }

}

extension GameBoard: BoardInputDelegate {

    func setInput(_ text: String) {
        if selectedTile?.text == text {
            selectedTile?.text = ""
        } else {
            selectedTile?.text = text
        }
        highlightTheSameTiles()
        checkIfError()
    }

    func setInput(_ text: String, forX x: Int, y: Int) {
        let index = y * 9 + x
        let tile = tiles[index]
        tile.text = text
    }

}

private extension GameBoard {

    func highlightTheSameTiles() {
        guard let selectedTile else { return }
        let selectedTileText = selectedTile.text

        for tile in self.tiles {
            tile.isHighlighted = tile.text == selectedTileText
        }
    }

}

private extension GameBoard {

    func checkIfError() {
        for i in 0..<tiles.count {
            let tile = tiles[i]
            let isValid = isValid(tile: tile, at: i)
            tile.isError = !isValid
        }
    }

    func isValid(tile: Tile, at index: Int) -> Bool {
        if tile.text == "" { return true }

        let startX = index - index % 9
        let endIndex = startX + 9

        for i in startX..<endIndex {
            if i == index { continue }

            let t = tiles[i]
            if t.text == tile.text {
                return false
            }
        }

        for i in stride(from: index, to: 81, by: 9) {
            if i == index { continue }
            let t = tiles[i]
            if t.text == tile.text {
                return false
            }
        }

        return true
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
                let tile = Tile(frame: .init(x: x * tileWidth + bounds.minX,
                                             y: y * tileWidth + bounds.minY,
                                             width: tileWidth,
                                             height: tileWidth),
                                scene: scene)
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
