//
//  DBHelper.swift
//  formoney
//
//  Created by 火星人 on 16/1/4.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//


import FMDB

let DB_NAME = "fql.db"

class DBHelper:NSObject {
    var dbQueue:FMDatabaseQueue!
    
    class var sharedInstance:DBHelper{
        struct Instance {
            static var onceToken:dispatch_once_t = 0
            static var instance:DBHelper!
        }
        
        dispatch_once(&Instance.onceToken, { () -> Void in
            Instance.instance = DBHelper()
            let path = Instance.instance.dbPath()
            Instance.instance.dbQueue = FMDatabaseQueue(path: path)
            Instance.instance.createTables()
        })
        
        return Instance.instance
    }
    
    func dbPath() -> String {
        return Helper.userDocumentDir() + "/\(User.sharedInstance.userId)" + "_\(DB_NAME)"
    }
    
    func deleteFromTable(table: String){
        
        self.deleteFromTable(table, withWhere: nil)
    }
    
    func deleteFromTable(table: String, withWhere: String!){
        
        var sql = "delete from \(table)"
        
        if withWhere != nil {
            sql += " where \(withWhere!)"
        }
        
        dbQueue.inDatabase { (db) in
            db.executeUpdate(sql, withArgumentsInArray: nil)
        }
    }
    
 

    /*
     * 写入数据
     */
    func writeToTable(table: String, withDictArray: NSArray, updateKey: String){
        self.writeToTable(table, withDictArray: withDictArray, updateKey: updateKey, complete: nil)
    }
    
    func writeToTable(table: String, withDictArray: NSArray, updateKey: String, complete: ((isSuccess: Bool, message: String) -> (Void))?){
        
        if withDictArray.count == 0 {
            if complete != nil {
                complete!(isSuccess: false, message: "数据库操作失败: 写入数据为空")
            }
        }
        
        self.dbQueue.inDatabase { [weak self] (db) in
            
            for dict in withDictArray{
                
                let indexId = dict.objectForKey(updateKey)
                if indexId == nil {
                    complete!(isSuccess: false, message: "数据库操作失败: 主键为空")
                    return
                }
                else{
                    
                    if dict.allKeys.count == 0 {
                        complete!(isSuccess: false, message: "数据库操作失败: 插入空数据")
                        return
                    }
                    var sql = "select * from \(table) where \(self!.key2String(updateKey)) = \(self!.key2String(indexId!))"
                    let resultSet = db.executeQuery(sql, withArgumentsInArray: nil)
                    
                    let allKeys = NSMutableArray()
                    let tmpKeys = dict.allKeys
                    // 移除表格中没有的键值
                    for key in tmpKeys {
                        //print(key)
                        if db.columnExists(key as! String, inTableWithName: table) {
                            allKeys.addObject(key)
                        }
                    }
                    
                    let count = allKeys.count
                    
                    if resultSet != nil {
                        if resultSet!.next() {
                            // 更新
                            
                            var set = ""
                            for i in 0 ..< count {
                                if allKeys[i] as! String == updateKey {
                                    continue
                                }
                                set += "\(self!.key2String(allKeys[i])) = \(self!.key2String(dict.objectForKey(allKeys[i])!)) ,"
                            }
                            if set.length() < 1 {
                                if complete != nil {
                                    complete!(isSuccess: false, message: "数据库操作失败: 没有发现要写入的数据")
                                }
                                return
                            }
                            set = (set as NSString).substringToIndex(set.length() - 1)
                            
                            let whereStr = "\(self!.key2String(updateKey)) = \(self!.key2String(indexId!))"
                            
                            sql = "update \(table) set \(set) where \(whereStr)"
                            
                            db.executeUpdate(sql, withArgumentsInArray:nil)
                            
                            resultSet?.close()
                            continue
                        }
                        resultSet?.close()
                    }
                    
                    // 插入
                    sql = "insert into \(table) ( "
                    
                    for i in 0 ..< count {
                        sql += self!.key2String(allKeys[i]) + ","
                    }
                    if sql.length() < 1 {
                        if complete != nil {
                            complete!(isSuccess: false, message: "数据库操作失败: 没有发现要写入的数据")
                        }
                        return
                    }
                    sql = (sql as NSString).substringToIndex(sql.length() - 1)
                    sql += " ) values ( "
                    for i in 0 ..< count {
                        sql +=  self!.key2String(dict.objectForKey(allKeys[i])!) + ","
                    }
                    sql = (sql as NSString).substringToIndex(sql.length() - 1)
                    
                    sql += " )"
                    
                    db.executeUpdate(sql, withParameterDictionary: nil)
                }
            }
            
            if complete != nil {
                complete!(isSuccess: true, message: "数据操作成功")
            }
        }
        
       
    }
    
   
    /*
     * 获取数据
     */
    func getContentFromTable(table: String) -> NSArray{
        return self.getContentFromTable(table, andWhere: nil, orderBy: nil)
    }
    
    func getContentFromTable(table: String, orderBy: String) -> NSArray{
        return self.getContentFromTable(table, andWhere: nil, orderBy: orderBy)
    }
    
    
    func getContentFromTable(table: String, andWhere: String?, orderBy: String?) -> NSArray{
        
        let array: NSMutableArray = NSMutableArray()
        
        self.dbQueue.inDeferredTransaction { (db, pointer) in
            
            var sql = ""
            
            if andWhere == nil && orderBy != nil{
                sql = "select * from \(table) order by \(orderBy!)"
            }
            else if orderBy == nil && andWhere != nil {
                sql = "select * from \(table) where \(andWhere!)"
            }
            else if  orderBy == nil && andWhere != nil {
                sql = "select * from \(table)"
            }
            else {
                sql = "select * from \(table) where \(andWhere!) order by \(orderBy!)"
            }
            
            let resultSet = db.executeQuery(sql, withArgumentsInArray: nil)
            if resultSet != nil {
                while resultSet!.next() {
                    array.addObject(resultSet!.resultDictionary())
                }
                
                resultSet!.close()
            }
        }
        
        return array
    }
    
    private func key2String(key: AnyObject) -> String{
        
        if key.isKindOfClass(NSString.classForCoder()) {
            return "\"\(key as! String)\""
        }
        else if key.isKindOfClass(NSNumber.classForCoder()) {
            return "\"\(key)\""
        }
        else if key.isKindOfClass(NSDictionary.classForCoder()) {
            return "\'\((key as! NSDictionary).mj_JSONString())\'"
        }
        else if key.isKindOfClass(NSArray.classForCoder()) {
            return "\'\((key as! NSArray).mj_JSONString())\'"
        }
        return "the_type_is_unavailable"
    }
    
    
}
 