//
//  File.swift
//  
//
//  Created by ccr on 29/10/2021.
//

import Foundation
import Vapor
import Fluent

protocol ResourceOutputModel: Content {
    associatedtype Model: Fields

    init(_: Model)
}


protocol ResourceUpdateModel: Content, Validatable {
    associatedtype Model: Fields

    func update(_: Model) -> Model
}

protocol ResourcePatchModel: Content, Validatable {
    associatedtype Model: Fields

    func patch(_: Model) -> Model
}
