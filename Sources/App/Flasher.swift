//
//  File.swift
//  
//
//  Created by ccr on 28/10/2021.
//

import Foundation
import Leaf

struct FlasherTagError: Error {}

class Flasher: LeafTag, UnsafeUnescapedLeafTag {
    func render(_ ctx: LeafContext) throws -> LeafData {
        guard let error = ctx.data["error"]?.string, !error.isEmpty else {
            return LeafData.string(nil)
        }
        return LeafData.string(
                """
                    <div id = "veda-falsher" class="alert alert-danger" role="alert">
                        \(error)
                    </div>
                """
        )}
}
