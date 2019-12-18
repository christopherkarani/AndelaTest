//
//  Webservice.swift
//  andela
//
//  Created by Chris Karani on 12/18/19.
//  Copyright © 2019 Chris Karani. All rights reserved.
//

import Foundation

extension URLSession {
    
    /// Loads an endpoint by creating (and directly resuming) a data task.
    ///
    /// - Parameters:
    ///   - R: The resource.
    ///   - onComplete: The completion handler.
    func load<R: Resource>(_ resource: R, onComplete: @escaping (Result<R.T, WebserviceError>) -> ()) {
        let request = URLRequest(resource: resource)
        URLSession.shared.dataTask(with: request) { data, response, error in
            let result: Result<R.T, WebserviceError>
            guard let parsed = data.flatMap (resource.parse) else {
                // incase the data in corrupted
                onComplete(.failure(WebserviceError.other(description: "Data parsing Error")))
                return
            }
            result = .success(parsed)
            DispatchQueue.main.async { onComplete(result) }
        }.resume()
    }
}


