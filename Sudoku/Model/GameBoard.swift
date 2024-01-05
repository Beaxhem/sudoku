//
//  GameBoard.swift
//  Sudoku
//
//  Created by Illia Senchukov on 04.01.2024.
//

import Foundation

final class GameBoard {

    private var tiles: [Tile] = []

    init(tiles: [Tile]) {
        self.tiles = tiles
    }

}

extension GameBoard {

    func checkIfError() -> Bool {
        var madeError = false
        for i in 0..<tiles.count {
            let tile = tiles[i]
            let isValid = isValid(tile: tile, at: i)
            madeError = madeError || !isValid
            tile.isError = !isValid
        }

        return madeError
    }

    private func isValid(tile: Tile, at index: Int) -> Bool {
        if tile.value == 0 { return true }

        let startX = index - index % 9
        let endIndex = startX + 9

        for i in startX..<endIndex {
            if i == index { continue }

            let t = tiles[i]
            if t.value == tile.value {
                return false
            }
        }

        for i in stride(from: index, to: 81, by: 9) {
            if i == index { continue }
            let t = tiles[i]
            if t.value == tile.value {
                return false
            }
        }

        return true
    }


}

extension GameBoard {

    func highlightAll(withValue value: Int) {
        for tile in tiles {
            tile.isHighlighted = tile.value == value
        }
    }

}

extension GameBoard {

    func setInput(_ grid: [[Int]]) {
        var i = 0
        for y in grid {
            for value in y {
                tiles[i].value = value
                i += 1
            }
        }
    }

}

extension GameBoard {

    func tile(at pos: CGPoint) -> Tile? {
        for tile in tiles {
            if tile.intersects(point: pos) {
                return tile
            }
        }
        return nil
    }

}
