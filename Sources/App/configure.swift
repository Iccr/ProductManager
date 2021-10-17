import Fluent
import FluentPostgresDriver
import Vapor


// configures your application
public func configure(_ app: Application) throws {
    //ap uncomment to serve files from /Public folder
     app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.http.server.configuration.port = 3000
    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? 5433,
        username: Environment.get("DATABASE_USERNAME") ?? "ccr",
        password: Environment.get("DATABASE_PASSWORD") ?? "password",
        database: Environment.get("DATABASE_NAME") ?? "itemManager"
    ), as: .psql)

   
//    AppMigrations.all().forEach{app.migrations.add($0)}
    app.migrations.add(CreateProductMigration())
    app.migrations.add(CreateCategoryMigration())
    app.migrations.add(CreateProductCategoriesPivotMigration())
   
    Seed.seedProduct(db: app.db)
    Seed.seedCategory(db: app.db)
    
    try app.autoMigrate().wait()

    // register routes
    try routes(app)
}



class AppMigrations {
    static func all() -> [Migration] {
        return [
            CreateProductMigration(),
            CreateCategoryMigration(),
            CreateProductCategoriesPivotMigration(),
        ]
    }
}


enum AppSchema: String {
    case products, categories, product_categories
}
