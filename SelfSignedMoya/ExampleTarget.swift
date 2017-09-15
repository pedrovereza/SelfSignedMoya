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

    //Your url with self-signed certificate goes here
    var baseURL: URL { return URL(string:"https://localhost")! }

    var path: String { return "/" }

    var method: Moya.Method { return .get }

    var sampleData: Data { return Data() }

    var task: Task { return .requestPlain }

    var validate: Bool { return true }

    var headers: [String: String]? { return nil }
}
