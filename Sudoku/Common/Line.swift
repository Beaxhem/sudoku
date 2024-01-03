//
//  Line.swift
//  Sudoku
//
//  Created by Illia Senchukov on 03.01.2024.
//

import SpriteKit

class Line: SKShapeNode {

    init(from: CGPoint, to: CGPoint) {
        let pathToDraw = CGMutablePath()
        pathToDraw.move(to: from)
        pathToDraw.addLine(to: to)
        super.init()
        self.path = pathToDraw
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
