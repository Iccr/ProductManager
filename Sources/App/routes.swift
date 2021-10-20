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

  
    
    try app.register(collection: TodoController())
    try app.register(collection: ProductController())
    try app.register(collection: CategoryController())
    
}
