//
//  Acronym.swift
//  App
//
//  Created by zhengzhilin on 2020/7/16.
//

import Vapor
import FluentSQLite

//final class Acronym: Codable {
//    var id: Int?
//    var short: String
//    var long: String
//}
//
//extension Acronym: SQLiteModel {
//    typealias Database = SQLiteDatabase
//}

final class Acronym: SQLiteModel {
    typealias Database = SQLiteDatabase
    
    var id: Int?
    var short: String
    var long: String
}

extension Acronym: Migration {}

extension Acronym: Content {}

