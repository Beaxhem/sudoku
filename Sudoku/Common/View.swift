//
//  View.swift
//  Sudoku
//
//  Created by Illia Senchukov on 03.01.2024.
//

import SpriteKit

class View {

    var bounds: CGRect

    weak var scene: SKScene!

    init(bounds: CGRect, scene: SKScene!) {
        self.bounds = bounds
        self.scene = scene
    }

}
