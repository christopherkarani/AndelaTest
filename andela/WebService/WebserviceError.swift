//
//  WebserviceError.swift
//  andela
//
//  Created by Chris Karani on 12/18/19.
//  Copyright © 2019 Chris Karani. All rights reserved.
//

import Foundation

enum WebserviceError: Error {
    case notAuthenticated
    case other(description: String)
    case general(String)
    case statusCodeError(Int)
}

func logError<A>(_ result: Result<A, WebserviceError>) {
    guard case .failure(let e) = result else { return }
    assert(false, "\(e)")
}
