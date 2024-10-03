//
//  JSONSerializable.swift
//  kpZadatakSwift
//
//  Created by Aleksa Dimitrijevic on 3.10.24..
//

import Foundation

protocol JSONSerializable: Codable {
    
    /// JSON konstruktor
    init?(_ dictionary: NSDictionary?)
        
}
