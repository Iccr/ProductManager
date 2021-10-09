//
//  File.swift
//  
//
//  Created by ccr on 09/10/2021.
//

import Foundation
import Fluent

//Category
//    let id: Int?
//    let name: String
//    let sort: Int
//    let isMain: Bool
//    let createdAt, updatedAt, deletedAt: Date?
//    let subcategories: [CategoryResponseBody]
//    let translations: [TranslationContent]


struct CreateCategoryMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("category")
            .field("id", .int, .identifier(auto: true))
            .field("name", .string, .required)
            .field("sort", .int)
            .field("isMain", .bool, .sql(.default(true)))
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("deleted_at", .datetime)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("category").delete()
    }
    
    
}



