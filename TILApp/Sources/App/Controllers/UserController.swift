//
//  UserController.swift
//  App
//
//  Created by zhengzhilin on 2020/7/20.
//

import Vapor
import Fluent

struct UserController: RouteCollection {
    func boot(router: Router) throws {
        let routeGroup = router.grouped("api","users")
        
        //指定解码类型为User
        routeGroup.post(User.self, use: createHandler)          //创建用户
        routeGroup.get(use: getAllHandler)                      //获取所有用户
        routeGroup.get(User.parameter, use: getHandler)         //获取某个用户
        routeGroup.put(User.parameter, use: updateHandler)      //更新用户
        routeGroup.delete(User.parameter, use: deleteHandler)   //删除用户
    }
    
    func createHandler(_ req: Request, user: User) throws -> Future<User> {
        return user.save(on: req)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }
    
    func getHandler(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(User.self)
    }
    
    func updateHandler(_ req: Request) throws -> Future<User> {
        return try flatMap(to: User.self, req.parameters.next(User.self), req.content.decode(User.self)) { (user, updateUser) -> Future<User> in
            user.email = updateUser.email
            user.nickName = updateUser.nickName
            return user.save(on: req)
        }
    }

    func deleteHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(User.self)
            .delete(on: req)
            .transform(to: HTTPStatus.noContent)
    }
}
