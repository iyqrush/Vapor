//
//  Room.swift
//  App
//
//  Created by zhengzhilin on 2020/6/15.
//

import FluentPostgreSQL
import Vapor

final class Room: Codable {
    var id: UUID?
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

extension Room: PostgreSQLUUIDModel {
    typealias Database = PostgreSQLDatabase
}
extension Room: Content {}
extension Room: Migration {}
