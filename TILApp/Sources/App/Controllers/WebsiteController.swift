//
//  WebsiteController.swift
//  App
//
//  Created by zhengzhilin on 2020/7/20.
//

import Vapor
import Leaf

struct IndexContext: Encodable {
    let title: String
    let users: [User]?
}

struct UserContext: Encodable {
    let title: String
    let user: User?
}

struct WebsiteController: RouteCollection {
    func boot(router: Router) throws {
        router.get(use: indexHandler)
        router.get("user",User.parameter, use: userHandler)
    }
    
    func indexHandler(_ req: Request) throws -> Future<View> {
        return User.query(on: req).all().flatMap(to: View.self) { users in
            let context = IndexContext(title: "Home page",users: users)
            return try req.view().render("index_1",context)
        }
        
    }
    
    func userHandler(_ req: Request) throws -> Future<View> {
        return try req.parameters.next(User.self).flatMap(to: View.self) { user in
            let context = UserContext(title: "Detail",user: user)
            return try req.view().render("user",context)
        }
    }
}
