//
//  File.swift
//  
//
//  Created by ccr on 09/10/2021.
//

import Foundation
import Fluent


//
//Product
//var id: Int?
//let sku: String
//var name: String
//var description: String?
//var status: ProductStatus
//var createdAt: Date?
//var updatedAt: Date?
//var deletedAt: Date?

struct ProductMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("products")
            .field("id", .int, .identifier(auto: true))
            .field("sku", .string)
            .field("name", .string, .required)
            .field("description", .string)
            .field("status", .string, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("deleted_at", .datetime)
            .unique(on: "skui")
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("products").delete()
    }
    
    
}

//func prepare(on database: Database) -> EventLoopFuture<Void> {
//    return database.schema("todos")
//        .id()
//        .field("title", .string, .required)
//        .create()
//}
//
//func revert(on database: Database) -> EventLoopFuture<Void> {
//    return database.schema("todos").delete()
//}

//Product
//    var id: Int?
//    let sku: String
//    var name: String
//    var description: String?
//    var status: ProductStatus
//    var createdAt: Date?
//    var updatedAt: Date?
//    var deletedAt: Date?
