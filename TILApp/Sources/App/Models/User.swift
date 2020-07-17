//
//  User.swift
//  App
//
//  Created by zhengzhilin on 2020/7/17.
//


import Vapor
import FluentMySQL
import FluentSQLite

final class User: SQLiteModel {
    typealias Database = SQLiteDatabase
    var id: Int?
    var userName: String
    var email: String
    var nickName: String
    var nickName1: String
}

extension User: Migration {
    public static func prepare(on connection: Database.Connection) -> Future<Void> {
        return Database.create(self, on: connection) { builder in
            try addProperties(to: builder)
            //builder.addIndex(to: \.idBrand) // deprecated! 😭
        }.flatMap { _ -> EventLoopFuture<Void> in
            //添加唯一索引
            return connection.query("CREATE UNIQUE INDEX idx_username ON \"User\" (\"userName\")").transform(to: ())
        }
    }
}

