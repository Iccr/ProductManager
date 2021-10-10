//
//  File.swift
//  
//
//  Created by ccr on 09/10/2021.
//

import Foundation
import Fluent

final class ProductCategoryPivot: Model {
 
    static var schema = AppSchema.product_categories.rawValue
    
    @ID(custom: "id")
    var id: Int?
    
    @Parent(key: "product_id")
    var product: Product
    
    @Parent(key: "category_id")
    var category: Category
    
    
    init(id: Int? = nil, product: Product, category: Category) throws {
        self.id = id
        self.$product.id = try product.requireID()
        self.$category.id = try category.requireID()
    }
    init() {}
}
