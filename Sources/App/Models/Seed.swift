//
//  File.swift
//  
//
//  Created by ccr on 10/10/2021.
//

import Foundation
import Fluent



class Seed {
    
    
    static func seedProduct(db: Database) {
        Product.query(on: db).count().map { count  in
            if count == 0 {
                let p1 = Product(name: "Product 1", description: "This is test product 1", status: "available", sku: "skuasdflkja;sodifj")
                p1.create(on: db)
            }
        }
        
    }
    
    static func seedCategory(db: Database) {
        //        let p1 = Product(name: "Product 1", description: "This is test product 1", status: "available", sku: "skuasdflkja;sodifj")
        Category.query(on: db).count().map { count in
            if count == 0 {
                let v1 = Category(id: nil, name: "Category 1", sort: 0, isMain: true)
                Product.query(on: db).first().map { p in
                    if let p = p {
                        v1.save(on: db).map {
                            v1.$products.attach(p, on: db)
                        }
                        
                    }
                    
                }
            }
        }
    }
}
