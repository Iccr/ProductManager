import Fluent
import Vapor

func routes(_ app: Application) throws {
    let apiV1 = app.grouped("api", "v1")
    
//    api version 1
    
    app.get("products") { req in
        ProductController().index(req: req)
    }
    
    app.post("products") { req in
       try ProductController().create(req: req)
    }
    
    app.post("products", "new") { req in
       try ProductController().create(req: req)
    }
    
    try app.register(collection: TodoController())
}
