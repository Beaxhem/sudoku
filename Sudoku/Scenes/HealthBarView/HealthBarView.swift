//
//  HealthBarView.swift
//  Sudoku
//
//  Created by Illia Senchukov on 05.01.2024.
//

import SpriteKit

class HeartView {

    private var imageNode: SKSpriteNode!

    init(frame: CGRect) {
        let configuration = UIImage.SymbolConfiguration(paletteColors: [.red])
        let image = UIImage(systemName: "heart.fill", withConfiguration: configuration)!.withTintColor(.systemRed)
        let texture = SKTexture(image: image)
        imageNode = .init(texture: texture, color: .red, size: frame.size)
        imageNode.color = .white
        imageNode.position = frame.origin
        imageNode.size = frame.size
    }

}

extension HeartView {

    enum Style {
        case filled
        case unfilled
    }

    func setStyle(_ style: Style) {
        switch style {
        case .filled:
            let configuration = UIImage.SymbolConfiguration(paletteColors: [.red])
            let image = UIImage(systemName: "heart.fill", withConfiguration: configuration)!.withTintColor(.systemRed)
            imageNode.texture = SKTexture(image: image)
        case .unfilled:
            let configuration = UIImage.SymbolConfiguration(paletteColors: [.red])
            let image = UIImage(systemName: "heart", withConfiguration: configuration)!.withTintColor(.systemRed)
            imageNode.texture = SKTexture(image: image)
        }
    }

}

extension HeartView {

    func addAsChild(to scene: SKScene) {
        scene.addChild(imageNode)
    }

}

class HealthBarView: View {

    var hearts: [HeartView]!

    var maxHealth: Int

    init(maxHealth: Int, frame: CGRect, scene: SKScene) {
        let intrinsicSize = CGSize(width: Constant.heartSize.width * CGFloat(maxHealth) + (CGFloat(maxHealth) - 1) * Constant.spacing,
                                   height: Constant.heartSize.height)

        self.maxHealth = maxHealth
        super.init(bounds: .init(x: frame.width / 2 - intrinsicSize.width - 100,
                                 y: frame.height / 2 - intrinsicSize.height - 100,
                                 width: intrinsicSize.width,
                                 height: intrinsicSize.height),
                   scene: scene)

        setupHearts()
    }

}

extension HealthBarView {

    func setHealth(_ health: Int) {
        guard health >= 0 && health <= maxHealth else {
            return
        }

        for i in 0..<(health) {
            let heart = hearts[i]
            heart.setStyle(.filled)
        }

        for i in health..<maxHealth {
            let heart = hearts[i]
            heart.setStyle(.unfilled)
        }
    }

}

private extension HealthBarView {

    func setupHearts() {
        var hearts: [HeartView] = []
        for i in (0..<maxHealth) {
            let x = bounds.minX + CGFloat(i) * Constant.heartSize.width + CGFloat(i) * Constant.spacing + Constant.heartSize.width / 2
            let heartView = HeartView(frame: .init(origin: .init(x: x,
                                                                 y: bounds.midY),
                                                   size: Constant.heartSize))
            heartView.addAsChild(to: scene)
            hearts.append(heartView)
        }

        self.hearts = hearts
    }

}

private extension HealthBarView {

    enum Constant {
        static let heartSize = CGSize(width: 45, height: 40)
        static let spacing: CGFloat = 10
    }

}
