//
//  Record.swift
//  Snake
//
//  Created by Valentin Mironov on 17.04.2021.
//

import Foundation
struct Record: Codable{
    var name: String
    let count: Int
    private var date: Date = Date()
  
    init(name: String, count: Int){
        self.name = name
        self.count = count
    }
}
extension Record: CustomStringConvertible{
    var description: String {
        let dateForamter = DateFormatter()
        dateForamter.locale = Locale(identifier: "RU_ru")
        dateForamter.dateFormat = "dd MMM"
        let dateWithFormatting = dateForamter.string(from: date)
        return "Рекорд - \(count) \nПоставил(а) \(name), \(dateWithFormatting)"
    }
}

extension Record: Equatable{
    static func == (lhs: Record, rhs: Record) -> Bool {
        lhs.count == rhs.count
    }
    
    static func >= (lhs: Record, rhs: Record) -> Bool {
        lhs.count >= rhs.count
    }
    
    static func <= (lhs: Record, rhs: Record) -> Bool {
        lhs.count <= rhs.count
    }
    
    static func > (lhs: Record, rhs: Record) -> Bool {
        lhs.count > rhs.count
    }
    
    static func < (lhs: Record, rhs: Record) -> Bool {
        lhs.count < rhs.count
    }
}
