//
//  ResultAllert.swift
//  Snake
//
//  Created by Valentin Mironov on 17.04.2021.
//

import UIKit

struct ResultAlert {
    func createAlert(count: Int) -> UIAlertController{
        let records = getRecord(count: count)
        let allertMessage = getRecordDiscription(record: records.record, newRecord: records.newRecord)
        let alert = UIAlertController(title: "Игра окончена", message: allertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Закрыть", style: .default) { action in
            guard let name = alert.textFields?.first?.text else{
                return
            }
            guard var newRecord = records.newRecord else{
                return
            }
            newRecord.name = name
            self.saveRecord(newRecord)
        }
        if records.newRecord != nil{
            alert.addTextField { tf in
                tf.placeholder = "Введите Ваше имя"
            }
        }
        alert.addAction(action)
        return alert
    }
    
    private func getRecord(count: Int) -> (record: Record?, newRecord: Record?){
        var newRecord: Record?
        let record: Record? = ServiceLocator.db.record
        if record?.count ?? 0 < count{
            newRecord = Record(name: "Без имени", count: count)
        }
        return (record, newRecord)
    }
    
    private func getRecordDiscription(record: Record?, newRecord: Record?) -> String{
        var result = ""
        if let newRecord = newRecord{
            result = "Новый рекорд - \(newRecord.count)"
            if let oldRecord = record{
                result += "\n Предыдущий " + oldRecord.description
            }
        }else{
            result = record?.description ?? ""
        }
        return result
    }
    
    private func saveRecord(_ record: Record){
        ServiceLocator.db.record = record
    }
}
