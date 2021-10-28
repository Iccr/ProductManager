//
//  File.swift
//  
//
//  Created by ccr on 28/10/2021.
//

import Foundation
import Fluent
import Vapor




class ProductStore<Item> {
    
    
    func all<T: Model>(req: Request,  sortKeypath: FieldKey) throws -> EventLoopFuture<[T]> {
        return T.query(on: req.db).sort(sortKeypath, .descending).all()
    }
    
    func add<T: Model>(req: Request) throws -> EventLoopFuture<T> {
        let toAdd =  try req.content.decode(T.self)
        return toAdd
            .save(on: req.db)
            .map { toAdd }
    }
    
    func update<T: Model>(req: Request) throws -> EventLoopFuture<T> {
        let toUpdate = try req.content.decode(Product.UpdateQuery.self)
        let id = req.parameters.get("id", as: Int.self)
        return Product.find(id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { product in
                var product = product
                return  Product
                    .updateFields(from: toUpdate, product: product)
                    .update(on: req.db)
                    .map({ product})
            }
    }
    
    func delete(req: Request) throws -> EventLoopFuture<Product> {
        let toDeleteId = try req.content.decode(Product.DeleteQuery.self).id
        return Product.find(toDeleteId, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { result in
                return result.delete(on: req.db).map {
                    result
                }
            }
    }
}







