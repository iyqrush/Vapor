//
//  WebsiteController.swift
//  App
//
//  Created by zhengzhilin on 2020/6/15.
//

import Vapor
import Leaf

struct IndexContext: Encodable {
    let title: String
    let acronyms: [Acronym]?
}

class WebsiteController: RouteCollection {
    func boot(router: Router) throws {
        router.get(use: indexHandler)
    }
    
    func indexHandler(_ req: Request) throws -> Future<View> {
        return Acronym.query(on: req)
            .all()
            .flatMap(to: View.self) { acronyms in
              // 2
              let acronymsData = acronyms.isEmpty ? nil : acronyms
              let context = IndexContext(title: "Home page",acronyms: acronymsData)
              return try req.view().render("index", context)
          }
    }

}
