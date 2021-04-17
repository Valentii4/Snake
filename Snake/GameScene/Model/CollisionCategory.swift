//
//  CollisionCategory.swift
//  Snake
//
//  Created by Valentin Mironov on 15.04.2021.
//

import Foundation
struct CollisionCategory {
    static let Snake: UInt32 = 0x1 << 0 //0001
    static let SnakeHead: UInt32 = 0x1 << 1 //0010
    static let Apple: UInt32 = 0x1 << 2 //0100
    static let EdgeBody: UInt32 = 0x1 << 3 //1000
}
