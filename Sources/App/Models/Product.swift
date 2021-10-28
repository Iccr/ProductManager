//
//  File.swift
//  
//
//  Created by ccr on 09/10/2021.
//

import Foundation
import Fluent
import Vapor

final class Product: Model, Content {
    // Name of the table or collection.
    static let schema = AppSchema.products.rawValue
    
    @ID(custom: "id")
    var id: Int?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "description")
    var description: String?
    
    @Field(key: "status")
    var status: String?
    
    @Field(key: "sku")
    var sku: String?
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
     var updatedAt: Date?
    
    
    @Siblings(through: ProductCategoryPivot.self, from: \.$product, to: \.$category)
    public var category: [Category]

    init() { }

    // Creates a new Planet with all properties set.
    init(id: Int? = nil, name: String, description: String, status: String?, sku: String?) {
        self.id = id
        self.name = name
        self.description = description
        self.status = status
        self.sku = sku
    }
}

// input output & querries
extension Product {
    struct Output {
        var id: Int?
        var name: String
        var description: String?
        var status: String?
        var sku: String?
        var createdAt: Date?
         var updatedAt: Date?
    }
    
    struct SearchQuery {
        var id: Int?
        var name: String?
        var description: String?
        var status: String?
        var sky: String?
    }
}

// context
extension Product {
    struct NewContext: Encodable {
        var name: String = "New Product"
        var categories: [Category] = []
    }
    
}
