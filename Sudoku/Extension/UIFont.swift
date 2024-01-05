//
//  UIFont.swift
//  Sudoku
//
//  Created by Illia Senchukov on 05.01.2024.
//

import SceneKit

extension UIFont {

    var rounded: UIFont {
        if let descriptor = fontDescriptor.withDesign(.rounded) {
            return .init(descriptor: descriptor, size: self.pointSize)
        }
        return self
    }

}
