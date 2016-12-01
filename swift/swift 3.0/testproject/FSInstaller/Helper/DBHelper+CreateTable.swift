//
//  DBHelper.swift
//  formoney
//
//  Created by 火星人 on 16/1/4.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

let kTableTask = "tb_task"


import FMDB

extension DBHelper {
    
    func createTables(){
        
        self.dbQueue.inDatabase { (db) -> Void in
            
            if db?.tableExists(kTableTask) == false {
                let sql = "create table \(kTableTask) (visitOrderNo text, category text, changeServiceDate text, changeServicePeriod text, distributeTime text, houseno text, period text, quesDesc text, roomno text,  reservationServiceTime text, status text, uid text, propertyAddr text, linkMan text, linkPhone text, product text, type text, workSheetStatus text, record text)"
                db?.executeStatements(sql)
            }
        }
    }
    
    
    func deleteTask(visitOrderNo: String?){
        if visitOrderNo != nil {
            deleteFromTable(kTableTask, withWhere: "visitOrderNo = \'\(visitOrderNo!)\'")
        }
    }
    
    func clearTask(){
        deleteFromTable(kTableTask)
    }
    
    func clearTask(withWhere: String){
        deleteFromTable(kTableTask, withWhere: withWhere)
    }
}
 
