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
    
    router.post("api", "acronyms") { req -> Future<Acronym> in
        return try req.content.decode(Acronym.self).flatMap(to: Acronym.self) { acronym in
            return acronym.save(on: req)
        }
    }
    
    router.get("api", "acronyms") { req -> Future<[Acronym]> in
//        //返回所有的数据
//        return Acronym.query(on: req).all()
        //条件查询
        return Acronym.query(on: req).filter(\Acronym.short, .equal, "OMG").filter(\Acronym.long, .equal, "oh my god").all()
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
    
    
}
