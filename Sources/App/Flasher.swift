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
struct FlasherTagError: Error {}
class Flasher: LeafTag, UnsafeUnescapedLeafTag {
    func render(_ ctx: LeafContext) throws -> LeafData {
        guard let error = ctx.data["error"]?.string, !error.isEmpty else {
            return LeafData.string(nil)
        }
        return LeafData.string(
                """
                    <div class="alert alert-danger" role="alert">
                        \(error)
                    </div>
                """
        )}
}
