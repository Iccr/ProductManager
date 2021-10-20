//
//  File.swift
//  
//
//  Created by ccr on 20/10/2021.
//

import Foundation
import Vapor

class CategoryController {
    
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
        let product =  try req.content.decode(Product.self)
        
       return product.save(on: req.db)
            .map {
                req.redirect(to: "products")
            }
        
    }
    
    func new(req: Request) throws -> EventLoopFuture<View> {
        return req.view.render("admin/pages/newProduct", ["title": "New Producti"])
    }
    
}
