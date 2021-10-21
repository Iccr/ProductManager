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
        category.post("delete" ,use: delete)
        category.post(":id", use: update)
        category.get(":id", "edit" ,use: edit)
        
        
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
    
    func delete(req: Request) throws -> EventLoopFuture<Response> {
        let toDelete = try req.content.decode(Category.Query.self)
        return category(toDelete.id, on: req)
            .flatMap { _category in
                if let category = _category {
                    return category.delete(on: req.db).map {
                        return req.redirect(to: "/categories")
                    }
                }
                return req.eventLoop.makeSucceededFuture(req.redirect(to: "/categories"))
            }
  
    }
    
    func update(req: Request) throws -> EventLoopFuture<Response> {
        let toUpdate = try req.content.decode(Category.self)
        let id = req.parameters.get("id", as: Int.self)
        
        return category(id, on: req).flatMap { category in
            if let category = category {
                category.name = toUpdate.name
                category.isMain = toUpdate.isMain
                return category.update(on: req.db).map({
                    req.redirect(to: "/categories")
                })
            }else {
                return req.eventLoop.makeSucceededFuture(req.redirect(to: "/categories"))
            }
            
        }
            
    }
    
    
    
    private func _categoryParitalFor(_ req: Request) -> EventLoopFuture<View>{
        let id = req.parameters.get("id", as: Int.self)
        struct CategoryContext: Encodable {
            var title = "Product Manager"
            var category: Category?
           var action = "/categories"
        }
        
        return  Category
            .find(id, on: req.db)
            .flatMap { _category in
            
         return req.view.render("admin/pages/newCategory",
                CategoryContext(
                    category: _category,
                    action: _category == nil ? "/categories": "/categories/\(id!)"
                ))
         }
    }
    
    private func category(_ id: Int?, on req: Request) -> EventLoopFuture<Category?> {
         Category.find(id, on: req.db)
    }
    
    
}
