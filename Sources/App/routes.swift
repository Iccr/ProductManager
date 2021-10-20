import Fluent
import Vapor


enum AppRoutes: String {
    case products, categories
}

    
func routes(_ app: Application) throws {
//    let apiV1 = app.grouped("api", "v1")
    
//    api version 1
    
    
    app.get { req in
        ProductController().index(req: req)
    }
    app.get("products") { req in
        ProductController().index(req: req)
    }
    
    app.post("products") { req in
       try ProductController().create(req: req)
    }
    
    app.get("products", "new") { req in
       try ProductController().new(req: req)
    }
    
    app.get("categories") { req in
        try CategoryController().index(req: req)
    }
    
    app.get("categories", "new") { req in
        try CategoryController().new(req: req)
    }
    
    app.post("categories") { req in
        try CategoryController().create(req: req)
    }
    
    try app.register(collection: TodoController())
}
