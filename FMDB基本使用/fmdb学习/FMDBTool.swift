//
//  FMDBTool.swift
//  fmdb学习
//
//  Created by haoran on 2018/1/16.
//  Copyright © 2018年 fclassroom. All rights reserved.
//

import UIKit


class FMDBTool: NSObject {

    static let shareInstance = FMDBTool()
    
    let  p  = Person()
    let tableName = "t_stu"
    
    
    
    lazy var db :FMDatabase = {
      
        let path = "/Users/haoran/Desktop/fmdb学习/demo.sqlite"
        let db = FMDatabase(path: path)
        return db!
    }()
    
    
    override init() {
        super.init()
        
        if db.open(){
            print("数据库打开成功")
        }else{
            print("数据库打开失败")
        }
    }
    
    
    /// 建表
    func creatTable() {
        
        let sql = "create table if not exists \(tableName)(id integer primary key autoincrement,  name text not null ,age integer , score real default 60)"
        if db.executeUpdate(sql, withArgumentsIn: []) {
            print("创建stu表成功")
        }else{
            print("创建stu表失败")
        }
        
    }
    
    
    /// 删除表
    func dropTable() {
        
        let sql = "drop table if exists t_stu"
        if db.executeUpdate(sql, withArgumentsIn: nil){
            print("删除表成功")
        }else{
            print("删除表成功")
        }
        
    }
    
    /// 插入数据
    func insertStu(){
        
        let nameArray = ["zhangsan" , "lisi" ,"wangba"]
        
        for (index , name) in nameArray.enumerated() {
            
            let sql  =  "insert into \(tableName)(name,age,score) values('\(name)', 18 , 78)"
            
            if db.executeUpdate(sql, withArgumentsIn: nil){
                print("插入学生: \(name) 数据成功❤️")
            }else{
                print("插入学生: \(name) 数据失败😭")
            }
        }
    }
    
    /// 删除数据
    func deleteStu(){
        
        let sql = "delete from t_stu where name = 'zhangsan'"
        
        do{
            try db.executeUpdate(sql, values: nil)
        }catch{
            print(error)
        }
    }
    
    
    /// 更新李四数据
    func updateStu() {
        
        let sql = "update t_stu set age = 22 where name = 'lisi'"
        if db.executeUpdate(sql, withArgumentsIn: nil){
            print("更新lisi数据成功❤️")
        }else{
            print("更新lisi数据失败😭")
        }
        
    }
    
    
    /// 查询
    func queryAll() {
        
        let sql = "select * from t_stu where name = 'wangba'"
        if let resultSet = db.executeQuery(sql, withArgumentsIn: nil){
            
            while resultSet.next() {
                let age = resultSet.int(forColumn: "age")
                let name = resultSet.string(forColumn: "name")
                let score = resultSet.double(forColumn: "score")
                print(age , name ?? "名字" , score)
            }
        }
       
        
    }
}




