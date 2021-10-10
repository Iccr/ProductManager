//
//  File.swift
//  
//
//  Created by ccr on 10/10/2021.
//

import Foundation
import Vapor

class ProductController {
    
    func index(req: Request) -> EventLoopFuture<View> {
        
        return req.view.render("index", ["title": "Product manager"])
    }
    
}
