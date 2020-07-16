import Vapor

//定义返回响应
struct Response<T: Content>: Content {
    var code: Int
    var message: String
    var data: T
}

struct ResponseData: Content {
    var firstName: String
    var lastName: String
}

struct InfoData: Content {
    var name: String
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
    
    router.get("hello", "Vapor") { req in
        return "Hello, Vapor"
    }
    
    router.get("hello", String.parameter) { req -> String in
        let name = try req.parameters.next(String.self)
        return "hello \(name)"
    }
    
    //返回JSON
    router.get("hello", "api") { req in
//        return Response(code: 0, message: "success",data: ResponseData(firstName: "zhilin", lastName: "zheng"))
        return Response(code: 0, message: "success",data: InfoData(name: "zhilinzheng"))
    }
    
    router.post(InfoData.self, at: "user") { req, data in
        return "Hello \(data.name)"
        
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
    
    //Acronyms router
//    let acronymsController = A
}
