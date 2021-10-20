//
//  File.swift
//  
//
//  Created by ccr on 10/10/2021.
//

import Foundation
import Vapor
import Fluent

class ProductController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let product = routes.grouped("products")
        product.get( use: index)
        product.post( use: create)
        product.get("new", use: new)
    }
    
    func index(req: Request) -> EventLoopFuture<View> {
        
        struct ProductContext: Encodable {
            var title = "Product Manager"
            var products: [Product]
        }
//        let query = req.query.decode(Product.SearchQuery.self)
        return Product.query(on: req.db)
            .all().flatMap { products in
                return req.view.render("admin/pages/products", ProductContext(products: products))
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
