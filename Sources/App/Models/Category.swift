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
//
//      subcategories =  many to many with product through ProductCategory
//        many


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
    
    @Field(key: "subcategories")
    var subcategories: Category?
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
     var updatedAt: Date?
    
    @Siblings(through: ProductCategoryPivot.self, from: \.$category, to: \.$product)
    public var products: [Product]
    
    init() {}
    
    init(id: Int?, name: String, sort: Int?, isMain: Bool, subcategories: Category?) {
        self.id = id
        self.name = name
        self.sort = sort
        self.isMain = isMain
        self.subcategories = subcategories
    }
}


