//
//  001_AddEmail.swift
//  App
//
//  Created by zhengzhilin on 2020/7/17.
//

import Vapor
import FluentSQLite
import FluentMySQL

struct V1: Migration {
    typealias Database = SQLiteDatabase
    
    //数据库变更
    static func prepare(on connection: Database.Connection) -> Future<Void> {
        let _ = Database.update(User.self, on: connection) { builder in
            builder.field(for: \.password, type: .text, .default(.literal("")))
        }
        
        return Database.update(Todo.self, on: connection) { builder in
            builder.field(for: \.detail, type: .text, .default(.literal("")))
        }
    }
    
    //撤回操作
    static func revert(on connection: Database.Connection) -> Future<Void> {
        return Database.update(User.self, on: connection) { builder in
            //如果是sqlite数据库的话，则无法删除字段
            builder.deleteField(for: \.password)
        }
    }
}
