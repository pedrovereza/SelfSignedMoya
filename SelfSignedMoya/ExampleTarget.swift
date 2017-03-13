//
//  Provider.swift
//  SelfSignedMoya
//
//  Created by Pedro Vereza on 3/13/17.
//  Copyright © 2017 Pedro Vereza. All rights reserved.
//

import Foundation
import Moya


enum ExampleTarget {
    case example
}


extension ExampleTarget : TargetType {

    //Random website with Self signed SSL certificate
    var baseURL: URL { return URL(string:"https://ride.com")! }

    var path: String { return "/" }

    var method: Moya.Method { return .get }

    var parameters: [String: Any]? { return [:] }

    var parameterEncoding: ParameterEncoding { return URLEncoding.default }

    var sampleData: Data { return Data() }

    var task: Task { return .request }

    var validate: Bool { return true }
}
