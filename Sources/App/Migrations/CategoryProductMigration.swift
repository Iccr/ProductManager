//
//  File.swift
//  
//
//  Created by ccr on 09/10/2021.
//

import Foundation
import Fluent


struct CreateProductCategoriesPivotMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(AppSchema.product_categories.rawValue)
            .field("id", .int, .identifier(auto: true))
            .field("product_id", .int, .required, .references(AppSchema.products.rawValue, "id", onDelete: .cascade, onUpdate: .cascade))
            .field("category_id", .int, .required, .references(AppSchema.categories.rawValue, "id", onDelete: .cascade, onUpdate: .cascade))
            .unique(on: "product_id", "category_id")
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(AppSchema.product_categories.rawValue).delete()
    }
}
