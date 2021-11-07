//
//  File.swift
//  
//
//  Created by ccr on 09/10/2021.
//

import Foundation
import Fluent
import Vapor

final class Category: Model {
    static let schema = AppSchema.categories.rawValue
    
    @ID(custom: "id")
    var id: Int?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "sort")
    var sort: Int?
    
    @Field(key: "isMain")
    var isMain: Bool
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
     var updatedAt: Date?
    
    @Siblings(through: ProductCategoryPivot.self, from: \.$category, to: \.$product)
    public var products: [Product]
    
    init() {}
    
    init(id: Int?, name: String, sort: Int?, isMain: Bool) {
        self.id = id
        self.name = name
        self.sort = sort
        self.isMain = isMain
    }
    
    struct Query: Codable {
        var id: Int?
        var name: String?
    }
}


extension Category {
    var output: Output {
        return .init(id: self.id, name: self.name, isMain: self.isMain, productCount: self.products.count)
    }
    
    struct Output: Content {
        var id: Int?
        var name: String
        var isMain: Bool = false
        var productCount: Int?
    }
}

extension Category {
    struct AllContext: Content {
        var title = "Product Manager"
        var categories: [Category.Output]
    }

}
