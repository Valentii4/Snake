//
//  DataBase.swift
//  Snake
//
//  Created by Valentin Mironov on 17.04.2021.
//

import Foundation
protocol DataBase{
   
    var record: Record? { get set }
    func getRecord() throws -> Record
    func setRecord(record: Record)
}
