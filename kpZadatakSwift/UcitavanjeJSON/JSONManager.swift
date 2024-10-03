//
//  JSONManager.swift
//  kpZadatakSwift
//
//  Created by Aleksa Dimitrijevic on 3.10.24..
//

import Foundation
import UIKit

/// JSONManager instance
/// Contains all user common API requests
final class JSONManager: JSONService {


    // MARK: - Globals
    
    //Global shared instance should be used inside application
    static let shared = JSONManager()
    
    //MARK: - Init
    
    private init() {}
    
    
    /// `ResponseResult` is wrapper object that should be used with all api requests to get data from the server side.
    struct ResponseResult {
        let currentPage: Int
        let totalPages: Int
        let ads: [Ad]
    }
    
    //MARK: - API
    
    /// Function that should fetch and return array of Oglas data
    /// - Parameters:
    ///    - result: Result function that will be async executed once request is done
    func readFromFile(for page: Int, result: @escaping DataCallback) {
        guard let path = Bundle.main.path(forResource: "oglasi", ofType: "json") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],
               let listaOglasa = json["listaOglasa"] as? [NSDictionary] {
                let models = listaOglasa.compactMap {  AdList($0) }
                if let apiResponse = models.first(where: { $0.page == page }) {
                    result(.success(ResponseResult(currentPage: apiResponse.page, totalPages: apiResponse.pages, ads: apiResponse.ads)))
                }
            }
        }
        catch let error {
            result(.failure(error))
        }
    }
    
    
    /// Function that shuld fetch and return one adDetail data
    /// - Parameters:
    ///   - id: Specific id of the Oglas model to metch with detail of the specific Oglas.
    ///   - result: Result function that will be async executed once request is done
    func readDetailsFromFile(id: String, result: (Result<AdDetails?, Error>)->Swift.Void) {
        guard let path = Bundle.main.path(forResource: "oglasi", ofType: "json") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],
               let detaljiOglasa = json["detaljiOglasa"] as? [NSDictionary] {
                let model = detaljiOglasa.compactMap { AdDetails($0) }
                var adDetails = [AdDetails]()
                adDetails.append(contentsOf: model)
                result(.success(adDetails.first { $0.id == id }))
            }
        }
        catch let error {
            result(.failure(error))
        }
    }
    
}


