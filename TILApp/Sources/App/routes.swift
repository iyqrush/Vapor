import Vapor

//定义返回响应
struct Response<T: Content>: Content {
    var code: Int
    var message: String
    var data: T
}

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    //增 -> POST http://localhost:8001/api/users/
    router.post("api", "users")  { req -> Future<User> in
        return try req.content.decode(User.self).flatMap(to: User.self) { user in
            return user.save(on: req)
        }
    }
    
    //删  -> DELETE http://localhost:8001/api/users/1
    router.delete("api", "users", User.parameter) { req -> Future<HTTPStatus> in
        return try req.parameters.next(User.self).delete(on: req).transform(to: .noContent)
    }
    
    //改  -> PUT http://localhost:8001/api/users/1
    router.put("api","users", User.parameter) { req -> Future<User> in
        return try flatMap(to: User.self, req.parameters.next(User.self), req.content.decode(User.self)) { (user, updateUser) -> Future<User> in
            user.email = updateUser.email
            user.nickName = updateUser.nickName
            return user.save(on: req)
        }
    }
    
    //查全部  -> GET http://localhost:8001/api/users/
    router.get("api", "users") { req -> Future<[User]> in
        return User.query(on: req).all()
    }
    
    //查单个  -> GET http://localhost:8001/api/users/1
    router.get("api", "users", User.parameter) { req -> Future<User> in
        return try req.parameters.next(User.self)
    }
    

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
    
    //通过控制器主持路由，以达到MVC结构
    let userController = UserController()
    try router.register(collection: userController)
    
    
}
