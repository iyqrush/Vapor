//
//  0002_AddRooms.swift
//  App
//
//  Created by zhengzhilin on 2020/6/15.
//

import FluentPostgreSQL
import Vapor

final class AddRooms: Migration {
    static func prepare(on connection: PostgreSQLConnection) -> EventLoopFuture<Void> {
        let room1 = Room(name: "Foundation")
        let room2 = Room(name: "UIKit")
        let room3 = Room(name: "SwiftUI")
        _ = room1.save(on: connection).transform(to: ())
        _ = room2.save(on: connection).transform(to: ())
        return room3.save(on: connection).transform(to: ())
    }
    
    static func revert(on connection: PostgreSQLConnection) -> EventLoopFuture<Void> {
        let futures = ["Foundation", "UIKit", "SwiftUI"].map { name in
          return Room.query(on: connection).filter(\Room.name == name)
            .delete()
        }
        return futures.flatten(on: connection)
    }
    
    typealias Database = PostgreSQLDatabase
    
    

}
