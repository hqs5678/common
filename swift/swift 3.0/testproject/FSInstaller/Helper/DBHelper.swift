//
//  DBHelper.swift
//  formoney
//
//  Created by 火星人 on 16/1/4.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//


import FMDB
import MJExtension

let DB_NAME = "fstm.db"

class DBHelper:NSObject {
    var dbQueue:FMDatabaseQueue!
    
    static let shared: DBHelper = {
        DBHelper()
    }()
    
    override init() {
        super.init()
        setup()
    }
    
    fileprivate func setup(){
        let path = dbPath()
        dbQueue = FMDatabaseQueue(path: path)
        createTables()
//        appPrint("dbpath:  " + path)
    }
    
    
    func dbPath() -> String {
        return Helper.userDocumentDir() + "/\(User.shared.uid)" + "_\(DB_NAME)"
    }
    
    func deleteFromTable(_ table: String){
        
        self.deleteFromTable(table, withWhere: nil)
    }
    
    func deleteFromTable(_ table: String, withWhere: String!){
        
        var sql = "delete from \(table)"
        
        if withWhere != nil {
            sql += " where \(withWhere!)"
        }
        
        dbQueue.inDatabase { (db) in
            db?.executeUpdate(sql, withArgumentsIn: nil)
        }
    }
    
    
    
    /*
     * 写入数据
     */
    func writeToTable(_ table: String, withDictArray: NSArray, updateKey: String){
        self.writeToTable(table, withDictArray: withDictArray, updateKey: updateKey, complete: nil)
    }
    
    func writeToTable(_ table: String, withDictArray: NSArray, updateKey: String, complete: ((_ isSuccess: Bool, _ message: String) -> (Void))?){
        
        if withDictArray.count == 0 {
            if complete != nil {
                doInMainThread {
                    
                    complete!(false, "数据库操作失败: 写入数据为空")
                }
            }
        }
        
        doInBackground({
            
            self.dbQueue.inDatabase { [weak self] (db) in
                
                for tmp in withDictArray{
                    let dict = tmp as! NSDictionary
                    let indexId = dict.object(forKey: updateKey)
                    if indexId == nil {
                        doInMainThread {
                            
                            complete!(false, "数据库操作失败: 主键为空")
                        }
                        return
                    }
                    else{
                        
                        if (dict as AnyObject).allKeys.count == 0 {
                            doInMainThread {
                                
                                complete!(false, "数据库操作失败: 插入空数据")
                            }
                            return
                        }
                        var sql = "select * from \(table) where \(self!.key2String(updateKey as NSObject)) = \(self!.value2String(indexId! as! NSObject))"
                        let resultSet = db?.executeQuery(sql, withArgumentsIn: nil)
                        
                        let allKeys = NSMutableArray()
                        let tmpKeys = dict.allKeys
                        // 移除表格中没有的键值
                        for key in tmpKeys {
                            //appPrint(key)
                            if (db?.columnExists(key as! String, inTableWithName: table))! {
                                allKeys.add(key)
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
                                    set += "\(self!.key2String(allKeys[i] as! NSObject)) = \(self!.value2String(dict[allKeys[i]] as! NSObject)) ,"
                                }
                                if set.length() < 1 {
                                    if complete != nil {
                                        doInMainThread {
                                            complete!(false, "数据库操作失败: 没有发现要写入的数据")
                                        }
                                    }
                                    return
                                }
                                set = (set as NSString).substring(to: set.length() - 1)
                                
                                let whereStr = "\(self!.key2String(updateKey as NSObject)) = \(self!.value2String(indexId! as! NSObject))"
                                
                                sql = "update \(table) set \(set) where \(whereStr)"
                                
//                                appPrint(" ----  dbhelper sql: "+sql)
                                db?.executeUpdate(sql, withArgumentsIn:nil)
                                
                                resultSet?.close()
                                continue
                            }
                            resultSet?.close()
                        }
                        
                        // 插入
                        sql = "insert into \(table) ( "
                        
                        for i in 0 ..< count {
                            sql += self!.key2String(allKeys[i] as! NSObject) + ","
                        }
                        if sql.length() < 1 {
                            if complete != nil {
                                doInMainThread {
                                    
                                    complete!(false, "数据库操作失败: 没有发现要写入的数据")
                                }
                            }
                            return
                        }
                        sql = (sql as NSString).substring(to: sql.length() - 1)
                        sql += " ) values ( "
                        for i in 0 ..< count {
                            sql +=  self!.value2String(dict[allKeys[i]] as! NSObject) + ","
                        }
                        sql = (sql as NSString).substring(to: sql.length() - 1)
                        
                        sql += " )"
                        
//                        appPrint(" ----  dbhelper sql: "+sql)
                        db?.executeUpdate(sql, withParameterDictionary: nil)
                    }
                }
                
                if complete != nil {
                    doInMainThread {
                        
                        complete!(true, "数据操作成功")
                    }
                }
            }
            
            }, completion: nil)
        
        
    }
    
    
    /*
     * 获取数据
     */
    func getContentFromTable(_ table: String) -> NSArray{
        return self.getContentFromTable(table, andWhere: nil, orderBy: nil)
    }
    
    func getContentFromTable(_ table: String, orderBy: String) -> NSArray{
        return self.getContentFromTable(table, andWhere: nil, orderBy: orderBy)
    }
    
    
    func getContentFromTable(_ table: String, andWhere: String?, orderBy: String?) -> NSArray{
        
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
            
//            appPrint(" ----  dbhelper sql: "+sql)
            let resultSet = db?.executeQuery(sql, withArgumentsIn: nil)
            if resultSet != nil {
                while resultSet!.next() {
                    array.add(resultSet!.resultDictionary())
                }
                
                resultSet!.close()
            }
        }
        
        return array
    }
    
    fileprivate func key2String(_ key: NSObject) -> String{
        var str: String
        if key.isKind(of: NSString.classForCoder()) {
            str = "\(key as! String)"
        }
        else if key.isKind(of: NSDictionary.classForCoder()) {
            str = "\((key as! NSDictionary).mj_JSONString()!)"
        }
        else if key.isKind(of: NSArray.classForCoder()) {
            str = "\((key as! NSArray).mj_JSONString()!)"
        }
        else {
            str = "\(key)"
        }
        //appPrint(str)
        if str.length() == 0 {
            return "--"
        }
        else{
            return str
        }
    }
    
    fileprivate func value2String(_ key: NSObject) -> String{
        var str = key2String(key)
        if str.contains("\"") {
            str = str.base64String
        }
        return "\"\(str)\""
    }
    
    
}

