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
    
    func index(req: Request) -> EventLoopFuture<View> {
        
        struct ProductContext: Encodable {
            var title = "Product Manager"
            var products: [Product]
        }
        
        return Product.query(on: req.db).all().flatMap {
            return req.view.render("index", ProductContext(products: $0))
        }
    }
    
    
    func create(req: Request) throws -> EventLoopFuture<Response> {
        let product =  try req.content.decode(Product.self)
        product.status = "draft"
        product.description = "description"
       return product.save(on: req.db).map {
        return req.redirect(to: "/")
        }
        
    }
    
}
