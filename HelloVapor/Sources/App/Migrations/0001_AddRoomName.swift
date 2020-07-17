//
//  0001_AddRoomName.swift
//  App
//
//  Created by zhengzhilin on 2020/6/15.
//

import FluentPostgreSQL
import Vapor

struct AddRoomName: Migration {
    
    // 1
    typealias Database = PostgreSQLDatabase

    static func prepare(on connection: PostgreSQLConnection) -> Future<Void> {
        // 2
        return Database.update(Room.self, on: connection) { builder in
            
            // 3
            builder.field(for: \.name)
        }
    }

    // 4
    static func revert(on connection: PostgreSQLConnection) -> Future<Void> {
        return Database.update(Room.self, on: connection) { builder in
            builder.deleteField(for: \.name)
        }
    }
}
