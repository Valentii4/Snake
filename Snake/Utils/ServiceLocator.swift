//
//  ServiceLocator.swift
//  Snake
//
//  Created by Valentin Mironov on 17.04.2021.
//

import Foundation
class ServiceLocator {
    static var db: DataBase = DBUserDefault()
}
