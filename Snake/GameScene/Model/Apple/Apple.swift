//
//  Apple.swift
//  Snake
//
//  Created by Valentin Mironov on 14.04.2021.
//

import Foundation
import SpriteKit

class Apple: SKShapeNode {
    convenience init(position: CGPoint, diametr: Int){
        self.init()
    
        path = UIBezierPath(ovalIn: CGRect(x: -diametr/2, y: -diametr/2, width: diametr, height: diametr)).cgPath
        fillColor = .red
        lineWidth = 5
        strokeColor = UIColor.red.withAlphaComponent(0.7)
        self.position = position
        physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(diametr), center: .zero)
        self.physicsBody?.categoryBitMask = CollisionCategory.Apple
    }
}

