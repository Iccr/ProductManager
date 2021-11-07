//
//  File.swift
//  
//
//  Created by ccr on 28/10/2021.
//

import Foundation
import Vapor
import Fluent



class CategoryStore {

    func getAllCategory(req: Request) throws -> EventLoopFuture<[Category]> {
        return Category.query(on: req.db)
            .with(\.$products)
            .all()
    }
    
}

