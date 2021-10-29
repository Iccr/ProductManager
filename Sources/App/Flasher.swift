//
//  File.swift
//  
//
//  Created by ccr on 28/10/2021.
//

import Foundation
import Leaf
//
//#if(error):
//
//<div class="alert alert-danger" role="alert">
//
//</div>
//#endif


//struct HelloTagError: Error {}
//
//public func render(_ ctx: LeafContext) throws -> LeafData {
//
//        guard let name = ctx.parameters[0].string else {
//            throw HelloTagError()
//        }
//
//        return LeafData.string("<p>Hello \(name)</p>'")
//    }
//}

class Flasher: LeafTag {
    func render(_ ctx: LeafContext) throws -> LeafData {
        return LeafData.string("<p>Hello \()</p>'")
    }
}
