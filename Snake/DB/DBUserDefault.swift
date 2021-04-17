//
//  DBUserDefault.swift
//  Snake
//
//  Created by Valentin Mironov on 17.04.2021.
//

import Foundation
class DBUserDefault: DataBase {
    private let keyRecord = "max record"
    private let usDefault = UserDefaults.standard
    func getRecord() throws -> Record {
        guard let object = usDefault.object(forKey: keyRecord) as? Record else {
            throw Errors.notSave
        }
        
        return object
    }
    
    func setRecord(record: Record) {
        usDefault.set(record, forKey: keyRecord)
    }
    
    private let defaults = UserDefaults.standard
    
    var record: Record?{
        get {
            if let recordData = usDefault.object(forKey: keyRecord) as? Data {
                        let decoder = JSONDecoder()
                        if let getRecord = try? decoder.decode(Record.self, from: recordData) {
                            print("get getRecord from userDefault")
                            return getRecord
                        }
                    }
                    
                    print("Record not saved")
                    return nil
                }
                set {
                    do {
                        let res = try JSONEncoder().encode(newValue)
                        defaults.set(res, forKey: keyRecord)
                    } catch {
                        print("error saving new record")
                    }
                }
    }
    
    enum Errors: Error {
        case notSave
    }
}
