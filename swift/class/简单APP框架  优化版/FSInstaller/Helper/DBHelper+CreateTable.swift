//
//  DBHelper.swift
//  formoney
//
//  Created by 火星人 on 16/1/4.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

let kTableActs: String = "tb_acts"

let kTableAD: String = "tb_ad"

let kTableQnaire: String = "tb_qnaire"

let kTableMoneyHistory: String = "tb_money_history"


import FMDB

extension DBHelper {
    
    func createTables(){
//
//        self.dbQueue.inDatabase { (db) -> Void in
//            
//            
//            if db.tableExists(kTableActs) == false {
//                let sql = "create table \(kTableActs) (ID text, name text, addTime text, content text, images text, avatar text, share text, reprint text)"
//                db.executeStatements(sql)
//            }
// 
//            
//            
//            //
//            //            var title:String!
//            //            var publisherName:String!
//            //            var imgsURL:NSArray!
//            //            var rewardDetail:RewardDetail!
//            //
//            //
//            //            var cellHeight:CGFloat!
//            //
//            //            var id: String!
//            //            var optionTypes: NSDictionary!
//            //
//            //            var content: String!
//            //            var url: String!
//            //            var pics: String!
//            //            var totalCost: String!
//            //            var perHitCost: String!
//            //            var perForwardCost: String!
//            //            var perRecommendCost: String!
//            //            var perShareCost: NSDictionary!
//            //            var publishTime: String!
//            
//            if db.tableExists(kTableAD) == false {
//                let sql = "create table \(kTableAD) (id text, title text, content text, publisherName text, pics text, url text, totalCost text, perHitCost text, perForwardCost text, perRecommendCost text, perShareCost text, publishTime text, optionTypes text )"
//                db.executeStatements(sql)
//            }
//            
// 
//            if db.tableExists(kTableQnaire) == false {
//                let sql = "create table \(kTableQnaire) (id text, name text, answerDr text, publisherName text, remain text, totalCost text, publisherId text, perAnswerCost text , publishTime text, answerNum text)"
//                db.executeStatements(sql)
//            }
//
//            if db.tableExists(kTableMoneyHistory) == false {
//                let sql = "create table \(kTableMoneyHistory) (id text, num text, ts text, optType text, description text )"
//                db.executeStatements(sql)
//            }
//            
//            
//        }
    }
    
}
 
