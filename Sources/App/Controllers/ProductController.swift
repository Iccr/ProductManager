//
//  File.swift
//  
//
//  Created by ccr on 10/10/2021.
//

import Foundation
import Vapor
import Fluent

class ProductController {
    
    func index(req: Request) -> EventLoopFuture<[Product]> {
        
//        struct ProductContext: Encodable {
//            var title = "Product Manager"
//            var products: [Product]
//        }
//        let query = req.query.decode(Product.SearchQuery.self)
        return Product.query(on: req.db)
            .all()
            
            .map {
            return $0
        }
    }
    
    
    func create(req: Request) throws -> EventLoopFuture<Product> {
        let product =  try req.content.decode(Product.self)
        product.status = "draft"
        product.description = "description"
       return product.save(on: req.db)
            .map { product }
        
    }
    
    
    func new(req: Request) throws -> EventLoopFuture<View> {
        return req.view.render("products", ["title": "New Producti"])
    }
    
}
