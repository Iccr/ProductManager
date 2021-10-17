import Fluent
import Vapor

func routes(_ app: Application) throws {
    let apiV1 = app.grouped("api", "v1")
    
//    api version 1
    
    apiV1.get("products") { req in
        ProductController().index(req: req)
    }
    
    apiV1.post("products") { req in
       try ProductController().create(req: req)
    }
    
    try app.register(collection: TodoController())
}
