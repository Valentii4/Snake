//
//  GameScene.swift
//  Snake
//
//  Created by Valentin Mironov on 14.04.2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var startButton: SKLabelNode?
    private var stopButton: SKLabelNode?
    private var gameFrameRect: CGRect = .zero
    private var gameFrameView: SKShapeNode!
    private var snake: Snake?
    unowned let vc: UIViewController
    
    init(size: CGSize, vc: UIViewController) {
        self.vc = vc
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        setup(to: view)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches{
            guard let touchedNode = findTouchedNode(with: touches) else {
                return
            }
            
            if touchedNode.name ==  ControlButtons.letfButton.rawValue, let shapeNode = touchedNode as? SKShapeNode{
                snake?.moveCounterClockwise()
                shapeNode.fillColor = .green
            }else if touchedNode.name == ControlButtons.rightButton.rawValue, let shapeNode = touchedNode as? SKShapeNode{
                snake?.moveClockwise()
                shapeNode.fillColor = .green
            }else if touchedNode.name == ControlButtons.start.rawValue {
                start()
            } else if touchedNode.name == ControlButtons.stop.rawValue {
                stop()
            }
            
        }
    }
    private func findTouchedNode(with touches: Set<UITouch>) -> SKNode? {
        return touches.map { [unowned self] touch in touch.location(in: self) }
            .map { atPoint($0) }
            .first
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let touchLocation = touch.location(in: self)
            
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode, touchNode.name == ControlButtons.letfButton.rawValue || touchNode.name == ControlButtons.rightButton.rawValue else {
                return
            }
            touchNode.fillColor = .gray
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        snake?.move()
    }
    
}
extension GameScene: SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let collisionObject = bodyes - CollisionCategory.SnakeHead
        
        switch collisionObject {
        case CollisionCategory.Apple:
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            snake?.addBodyPart()
            apple?.removeFromParent()
            createApple()
            
        case CollisionCategory.EdgeBody:
            stop()
        default:
            break
        }
    }
}


//MARK: - Setting/Setup
extension GameScene{
    private func settingPhysics(){
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.allowsRotation = false
        self.view?.showsPhysics = true
        self.physicsWorld.contactDelegate = self
        self.physicsBody?.categoryBitMask = CollisionCategory.EdgeBody
        self.physicsBody?.collisionBitMask = CollisionCategory.Snake | CollisionCategory.SnakeHead
    }
    
    private func setup(to view: SKView){
        settingPhysics()
        backgroundColor = .black
        guard let scene = view.scene else {
            return
        }
        let letfButton = createButtom(position: CGPoint(x: scene.frame.minX + 30, y: scene.frame.minY + 55), diametr: 45, name: .letfButton)
        let rightButton = createButtom(position: CGPoint(x: scene.frame.maxX - 100, y: scene.frame.minY + 55), diametr: 45, name: .rightButton)
        startButton = createButton(name: .start)
        stopButton = createButton(name: .stop)
        stopButton?.isHidden = true
        self.addChild(startButton!)
        self.addChild(stopButton!)
        self.addChild(rightButton)
        self.addChild(letfButton)
        
        let margin: CGFloat = 20
        let gameFrame = frame.inset(by: view.safeAreaInsets)
        gameFrameRect = CGRect(x: margin, y: margin + view.safeAreaInsets.top + 55,
                               width: gameFrame.width - margin * 2, height: gameFrame.height - margin * 2 - 55)
        drawGameFrame()
    }
    
    final func drawGameFrame() {
        gameFrameView = SKShapeNode(rect: gameFrameRect)
        gameFrameView.fillColor = .black
        gameFrameView.lineWidth = 2
        gameFrameView.strokeColor = .gray
        self.addChild(gameFrameView)
    }
    
}
//MARK: - Create
extension GameScene{
    private func createApple(){
        let padding: UInt32 = 100
        let randX = CGFloat(arc4random_uniform(UInt32(gameFrameRect.maxX) - padding))
        let randY = CGFloat(arc4random_uniform(UInt32(gameFrameRect.maxY) - padding))
        var position = CGPoint(x: randX + gameFrameRect.origin.x, y: randY + gameFrameRect.origin.y)
        
        //Исключаем создание на каком-либо объекте
        for object in self.children{
            if object.position == position{
                position.x =  CGFloat(arc4random_uniform(UInt32(gameFrameRect.maxX) - padding))
                position.y = CGFloat(arc4random_uniform(UInt32(gameFrameRect.maxY) - padding))
            }
        }
        
        let apple = Apple(position: position, diametr: 10)
        gameFrameView.addChild(apple)
    }
    
    private func createButtom(position: CGPoint, diametr: CGFloat, name: ControlButtons) -> SKShapeNode{
        let btn = SKShapeNode()
        btn.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: diametr, height: diametr)).cgPath
        btn.alpha = 0.7
        btn.position = position
        btn.fillColor = .gray
        btn.strokeColor = .gray
        btn.lineWidth = 10
        btn.name = name.rawValue
        
        return btn
    }
    
    private func createButton(name: ControlButtons) -> SKLabelNode{
        let btn = SKLabelNode(text: name.rawValue)
        btn.position = CGPoint(x: scene!.frame.midX, y: 55)
        btn.fontSize = 40
        btn.fontColor = name == .stop ? UIColor.red : UIColor.green
        btn.name = name.rawValue
        return btn
    }
    
    private func createAlert(count: Int){
        let allert = ResultAlert().createAlert(count: count)
        vc.present(allert, animated: true)
    }
    
    private enum ControlButtons: String{
        case start = "S T A R T"
        case stop = "S T O P"
        case letfButton = "letfButton"
        case rightButton = "rightButton"
    }
}

//MARK: - Actions
extension GameScene{
    private func start() {
        guard let scene = scene else { return }
        snake = Snake(atPoint: CGPoint(x: scene.frame.midX, y: scene.frame.midY), angle: 0.0, countBodyPart: 2)
        gameFrameView.addChild(snake!)
        
        createApple()
        
        startButton?.isHidden = true
        stopButton?.isHidden = false
    }
    
    private func stop() {
        guard let snake = snake else { return }
        createAlert(count: snake.countBodyPart)
        self.snake = nil
        gameFrameView.removeAllChildren()
        
        startButton?.isHidden = false
        stopButton?.isHidden = true
    }
}
