//
//  ServicesContainer.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/2/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import Foundation

import Swinject

class ServicesContainer {
    static var `default`: Container = {
        let container = Container()
        
        container.register(ContentService.self, factory: { _ in
            ContentServiceImp()
        }).inObjectScope(.container)

        return container
    }()
}
