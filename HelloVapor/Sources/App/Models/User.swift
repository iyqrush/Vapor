//
//  User.swift
//  App
//
//  Created by zhengzhilin on 2020/6/15.
//

import Vapor
import FluentPostgreSQL

final class User: Codable {
    
    var id: UUID?
    var name: String
    var username: String
    
    init(name: String, username: String) {
        self.name = name
        self.username = username
    }
    
}

extension User: PostgreSQLUUIDModel {
    typealias Database = PostgreSQLDatabase
}

extension User: Migration {}
extension User: Content {}
extension User: Parameter {}
