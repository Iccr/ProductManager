//
//  File.swift
//  
//
//  Created by ccr on 20/10/2021.
//

import Foundation
import Vapor




class CategoryController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let category = routes.grouped("categories")
        category.get(use: index)
        category.get("new", use: new)
        category.post( use: create)
        }
    
    
    
    func index(req: Request) -> EventLoopFuture<View> {
        
        struct CategoryContext: Encodable {
            var title = "Product Manager"
            var categories: [Category]
        }
//        let query = req.query.decode(Product.SearchQuery.self)
        return Category.query(on: req.db)
            .all().flatMap { categories in
                return req.view.render("admin/pages/categories", CategoryContext(categories: categories))
            }
        }
    
    
    
    func create(req: Request) throws -> EventLoopFuture<Response> {
        let category =  try req.content.decode(Category.self)
        
       return category.save(on: req.db)
            .map {
                req.redirect(to: "categories")
            }
        
    }
    
    func new(req: Request) throws -> EventLoopFuture<View> {
        return req.view.render("admin/pages/newCategory", ["title": "New Category"])
    }
    
}
