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
        category.post(":id", use: update)
        category.get("edit", ":id" ,use: edit)
        
    }
    
    func index(req: Request) -> EventLoopFuture<View> {
        struct CategoryContext: Encodable {
            var title = "Product Manager"
            var categories: [Category]
        }
        
        return Category.query(on: req.db)
            .sort(\.$createdAt, .descending)
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
        return _categoryParitalFor(req)
    }
    
    func edit(req: Request) throws -> EventLoopFuture<View> {
    
       return _categoryParitalFor(req)
        
    }
    
    func update(req: Request) throws -> EventLoopFuture<Response> {
        let _category = try req.content.decode(Category.self)
        let id = req.parameters.get("id") == nil ? nil : Int(req.parameters.get("id")!)
        
        return Category.find(id, on: req.db).flatMap { category in
            if let category = category {
                category.name = _category.name
                category.isMain = _category.isMain
                return category.update(on: req.db).map({
                    req.redirect(to: "/categories")
                })
            }else {
                return req.eventLoop.makeSucceededFuture(req.redirect(to: "/categories"))
            }
            
        }
            
    }
    
    
    
    private func _categoryParitalFor(_ req: Request) -> EventLoopFuture<View>{
        let id = req.parameters.get("id") == nil ? nil : Int(req.parameters.get("id")!)
        return  Category.find(id, on: req.db).flatMap { _category in
             struct CategoryContext: Encodable {
                 var title = "Product Manager"
                 var category: Category?
                var action = "/categories"
                var method: String
             }
         return req.view.render("admin/pages/newCategory",
                CategoryContext(
                    category: _category,
                    action: id == nil ? "/categories": "/categories/\(id!)",
                    method: id == nil ?  "post" : "post"
                                
                ))
         }
    }
    
    
}
