//
//  Snake.swift
//  Snake
//
//  Created by Valentin Mironov on 14.04.2021.
//

import UIKit
import SpriteKit

class Snake: SKShapeNode{
    private var body = [SnakeBodyPart]()
    
    var countBodyPart: Int {
        body.count - 1
    }
    private(set) var angle: CGFloat = 0.0
    private let moveSpeed = 125.0
    private var bodySpeed: Double {
        speedHead/20
    }
    private var speedHead: Double {
        switch countBodyPart {
        case 0...10:
            return 2
        case 10...15:
            return 1.5
        case 15...20:
            return 1.0
        case 20...35:
            return 0.85
        case 35...:
            return 0.55
        default:
            return 1.7
        }
    }
    
    convenience init(atPoint point: CGPoint, angle: CGFloat, countBodyPart: Int ){
        self.init()
        self.angle = angle
        let head = SnakeHead(atPoint: point, diametr: 10)
        head.fillColor = .systemGreen
        body.append(head)
        addChild(head)
        for _ in 0..<countBodyPart{
            addBodyPart()
        }
    }
    
    func addBodyPart(){
        guard let firstPosition = body.first?.position else { return }
        let newBodyPart = SnakeBodyPart(atPoint: CGPoint(x: firstPosition.x, y: firstPosition.y ))
        body.append(newBodyPart)
        addChild(newBodyPart)
    }
    
    func move(){
        guard !body.isEmpty, let head = body.first else{
            return
        }
        moveHead(head)
        for index in 1..<body.count{
            let previousBodyPart = body[index - 1]
            let currentBodyPart = body[index]
            moveBodyPart(previousBodyPart, currentBodyPart)
        }
    }
    
    func moveClockwise(){
        angle += CGFloat(Double.pi/2)
    }
    
    func moveCounterClockwise(){
        angle -= CGFloat(Double.pi/2)
    }
    
   
    
    private func moveHead(_ head: SnakeBodyPart){
        let dx = CGFloat(moveSpeed) * sin(angle)
        let dy = CGFloat(moveSpeed) * cos(angle)
        
        let newPosition = CGPoint(x: head.position.x + dx, y: head.position.y + dy)
        let moveAction = SKAction.move(to: newPosition, duration: speedHead)
        head.run(moveAction)
    }
    
    private func moveBodyPart(_ p: SnakeBodyPart, _ c: SnakeBodyPart){
        let moveAction = SKAction.move(to: CGPoint(x: p.position.x, y: p.position.y), duration: bodySpeed)
        c.run(moveAction)
    }

}
