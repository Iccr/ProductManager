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
// var id: Int?
// let sku: String
// var name: String
// var description: String?
// var status: ProductStatus
// var createdAt: Date?
// var updatedAt: Date?
// var deletedAt: Date?
//
//categories =  many to many with categories through ProductCategory
//

final class Product: Model {
    // Name of the table or collection.
    static let schema = AppSchema.products.rawValue
    
    @ID(custom: "id")
    var id: Int?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "status")
    var status: String
    
    @Field(key: "sku")
    var sku: String
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
     var updatedAt: Date?
    
//    @Siblings(
    
//    @Siblings
    
//    @Siblings(through: PlanetTag.self, from: \.$planet, to: \.$tag)
//        public var tags: [Tag]

    init() { }

    // Creates a new Planet with all properties set.
    init(id: Int? = nil, name: String) {
        self.id = id
        self.name = name
        self.description = description
        self.status = status
        self.sku = sku
    }
}

