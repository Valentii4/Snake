//
//  GameViewController.swift
//  Snake
//
//  Created by Valentin Mironov on 14.04.2021.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setup()
    }

    private func setup() {
        guard let skView = view as? SKView else {
            return
        }

        let scene = GameScene(size: view.bounds.size, vc: self)
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
   
}
