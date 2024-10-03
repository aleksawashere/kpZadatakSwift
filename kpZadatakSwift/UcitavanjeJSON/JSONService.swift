//
//  JSONService.swift
//  kpZadatakSwift
//
//  Created by Aleksa Dimitrijevic on 3.10.24..
//

import Foundation

/// JSONService contain api methods for handling data
protocol JSONService {
    
    // Callback function that will be async executed once request is done.
    typealias DataCallback = (Result<(JSONManager.ResponseResult), Error>) -> Swift.Void

    /// Function that should fetch and return array of Oglas data
    /// - Parameters:
    ///    - result: Result function that will be async executed once request is done
    func readFromFile(for page: Int, result: @escaping DataCallback)

    /// Function that shuld fetch and return one adDetail data
    /// - Parameters:
    ///   - id: Specific id of the Oglas model to metch with detail of the specific Oglas.
    ///   - result: Result function that will be async executed once request is done
    func readDetailsFromFile(id: String, result: (Result<AdDetails?, Error>)->Swift.Void)
    
}

