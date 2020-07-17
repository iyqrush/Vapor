//
//  001_AddEmail.swift
//  App
//
//  Created by zhengzhilin on 2020/7/17.
//

import Vapor
import FluentSQLite
import FluentMySQL

struct AddEmail: Migration {
    typealias Database = SQLiteDatabase
    
    //数据库变更
    static func prepare(on connection: Database.Connection) -> Future<Void> {
        return Database.update(User.self, on: connection) { builder in
            builder.field(for: \.nickName1, type: .text, .default(.literal("")))
        }
    }
    
    //撤回操作
    static func revert(on connection: Database.Connection) -> Future<Void> {
        return Database.update(User.self, on: connection) { builder in
            builder.deleteField(for: \.nickName1)
        }
    }
}
