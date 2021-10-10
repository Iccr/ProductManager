import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        ProductController().index(req: req)
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }

    
    app.post("products") { req in
       try ProductController().create(req: req)
    }
    try app.register(collection: TodoController())
}
