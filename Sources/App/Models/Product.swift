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
    init(id: Int? = nil, name: String, description: String?, status: String?, sku: String?) {
        self.id = id
        self.name = name
        self.description = description
        self.status = status
        self.sku = sku
    }
}

// input output & querries
extension Product {
    struct Output: Content {
        var id: Int?
        var name: String
        var description: String?
        var status: String?
        var sku: String?
        var category: [Category]
        var categoryName: String
        var createdAt: Date?
        var updatedAt: Date?
    }
    
    struct Input:Content {
        var id: Int?
        var name: String
        var description: String?
        var status: String?
        var sku: String?
        var category_id: Int?
        
        func product() -> Product {
            return .init(id: self.id, name: self.name, description: self.description, status: self.status, sku: self.sku)
        }
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
    
    struct allContext: Encodable {
        var title = "Product Manager"
        var products: [Product.Output] = []
        var error: String?
    }
    
    struct NewContext: Encodable {
        var name: String = "New Product"
        var categories: [Category] = []
    }

    struct DeleteQuery: Content {
        var id: Int
    }
    
    struct UpdateQuery: Decodable {
        var id: Int
        var name: String
        var description: String?
        var status: String?
        var sku: String?
        var category_id: String?
    }
    
    static func updateFields(from: UpdateQuery, product: Product) -> Product {
        product.name = from.name
        product.sku = from.sku ?? product.sku
        product.status = from.status ?? product.status
        product.description = from.description ?? product.description
        return product
    }
}



extension Product {
    var output: Output {
        .init(id: self.id, name: self.name, description: self.description, status: self.status, sku: self.sku, category: self.category, categoryName: self.category.first?.name ?? "", createdAt: self.createdAt, updatedAt: self.updatedAt)
    }
}


