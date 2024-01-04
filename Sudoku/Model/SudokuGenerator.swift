//
//  SudokuGenerator.swift
//  Sudoku
//
//  Created by Illia Senchukov on 04.01.2024.
//

import Foundation

class SudokuGenerator {

    private var grid = Array(repeating: Array(repeating: 0, count: 9), count: 9)

    func generatePuzzle(numberOfClues: Int) -> [[Int]] {
        fillDiagonalBoxes()
        _ = fillRemainingCells(0, 3)
        removeDigits(numberOfClues: 81 - numberOfClues)
        return grid
    }

}

private extension SudokuGenerator {

    func fillDiagonalBoxes() {
        for i in 0..<3 {
            fillBox(row: i * 3, col: i * 3)
        }
    }

    func fillBox(row: Int, col: Int) {
        var num: Int
        for i in 0..<3 {
            for j in 0..<3 {
                repeat {
                    num = randomGenerator(9) + 1
                } while !unUsedInBox(rowStart: row, colStart: col, num: num)
                grid[row + i][col + j] = num
            }
        }
    }

    func randomGenerator(_ n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }

    func unUsedInBox(rowStart: Int, colStart: Int, num: Int) -> Bool {
        for i in 0..<3 {
            for j in 0..<3 {
                if grid[rowStart + i][colStart + j] == num {
                    return false
                }
            }
        }
        return true
    }

    func fillRemainingCells(_ i: Int, _ j: Int) -> Bool {
        var i = i
        var j = j
        if j >= 9 && i < 8 {
            i += 1
            j = 0
        }
        if i >= 9 && j >= 9 {
            return true
        }
        if i < 3 {
            if j < 3 {
                j = 3
            }
        } else if i < 6 {
            if j == Int(i/3)*3 {
                j += 3
            }
        } else {
            if j == 6 {
                i += 1
                j = 0
                if i >= 9 {
                    return true
                }
            }
        }

        for num in 1...9 {
            if checkIfSafe(i, j, num) {
                grid[i][j] = num
                if fillRemainingCells(i, j + 1) {
                    return true
                }
                grid[i][j] = 0
            }
        }
        return false
    }

    func checkIfSafe(_ x: Int, _ y: Int, _ num: Int) -> Bool {
        unUsedInRow(x, num) && unUsedInCol(y, num) && unUsedInBox(rowStart: x - x % 3, colStart: y - y % 3, num: num)
    }

    func unUsedInRow(_ i: Int, _ num: Int) -> Bool {
        for j in 0..<9 {
            if grid[i][j] == num {
                return false
            }
        }
        return true
    }

    func unUsedInCol(_ j: Int, _ num: Int) -> Bool {
        for i in 0..<9 {
            if grid[i][j] == num {
                return false
            }
        }
        return true
    }

    func removeDigits(numberOfClues: Int) {
        var count = 81 - numberOfClues
        while count > 0 {
            let i = randomGenerator(9)
            let j = randomGenerator(9)
            if grid[i][j] != 0 {
                count -= 1
                grid[i][j] = 0
            }
        }
    }
}
