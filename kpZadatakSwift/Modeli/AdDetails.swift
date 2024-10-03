//
//  AdDetails.swift
//  kpZadatakSwift
//
//  Created by Aleksa Dimitrijevic on 3.10.24..
//

import Foundation


class AdDetails: JSONSerializable, Identifiable {
    
    //MARK: - Globals
    let id: String
    let location: String
    let category: String
    let groupName: String
    let desription: String
    let photo: String
    
    //MARK: - Init
    
    init(id: String, location: String, category: String, groupName: String, desription: String, photo: String) {
        self.id = id
        self.location = location
        self.category = category
        self.groupName = groupName
        self.desription = desription
        self.photo = photo
    }
    
    //MARK: JSONSerializable
    required init?(_ dictionary: NSDictionary?) {
        guard let
                dictionary = dictionary,
              let id         = dictionary.value(forKeyPath: "ad_id") as? String,
              let location   = dictionary.value(forKeyPath: "location_name") as? String,
              let category   = dictionary.value(forKeyPath: "cateogry_name") as? String,
              let groupName  = dictionary.value(forKeyPath: "group_name") as? String,
              let desription = dictionary.value(forKeyPath: "description") as? String,
              let photo      = dictionary.value(forKeyPath: "photos") as? String
        else {
            return nil
        }
        
        self.id = id
        self.location = location
        self.category = category
        self.groupName = groupName
        self.desription = desription
        self.photo = photo
    }
    
    
    var returnURLString: String {
        "/\(photo)"
    }
}
