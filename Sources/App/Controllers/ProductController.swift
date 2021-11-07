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
        product.post("delete", use: delete)
    }
    
    func index(req: Request) -> EventLoopFuture<View> {
        let error: String? = req.query["error"]
        do {
            return try ProductStore().all(req: req).mapEach({$0.output})
                .flatMap { products in
                    return req.view.render(
                        "/admin/pages/products",
                        Product.allContext(products: products, error: error)
                    )
                }
        } catch (let error) {
            return  req.view.render("/admin/pages/products", Product.allContext(error: error.localizedDescription))
        }
        
    }
    
    func create(req: Request) throws -> EventLoopFuture<Response> {
        
        do {
            return try ProductStore().add(req: req).map { product in
                req.redirect(to: "/products")
                
            }
        } catch (let error) {
            return  req.eventLoop.makeSucceededFuture(req.redirect(to: "/products/?error=\(error.localizedDescription)"))
        }
        
    }
    
    func new(req: Request) throws -> EventLoopFuture<View> {
        try CategoryStore().getAllCategory(req: req).flatMap { categories in
            let context = Product.NewContext(name: "New Product", categories: categories)
            return req.view.render("/admin/pages/newProduct", context)
        }
       
    }
    
    func delete(req: Request) throws -> EventLoopFuture<Response> {
        try ProductStore().delete(req: req).map({ _ in
            req.redirect(to: "/products")
        })
    }
}

