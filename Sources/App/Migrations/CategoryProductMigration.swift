//
//  File.swift
//  
//
//  Created by ccr on 09/10/2021.
//

import Foundation
import Fluent


struct CreateProductCategoryPivot: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("product_category")
            .field("id", .int, .identifier(auto: true))
            .field("product_id", .int, .required, .references("products", "id", onDelete: .cascade, onUpdate: .cascade))
            .field("category_id", .int, .required, .references("category", "id", onDelete: .cascade, onUpdate: .cascade))
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("product_category").delete()
    }
}
